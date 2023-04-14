Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362356E1A8D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 04:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjDNCzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 22:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDNCzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 22:55:18 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7942722
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 19:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=arnTy/k2SDXcsFTbM5uG7lhSXpUi+P+pNKJGwnp46Os=; b=gDsGw3PKon86S5e5ztCdSyuKHR
        bQpcFt9JrAMlPnGiC+gQB6h97/MuUfdXbtPnuEA0stj/Z8fa6b3Be9EMNzWv7KvbRntbFQjoRBCvG
        KtqxJPp3TbJfedpipSmo8BeRLICvNurjags46myra516KT3Vy4wR+zcZm5+JMJDKMiM0w93j9m6CI
        ogvbo7AlFbFyV3X1DUnrPDFgHAWZEbz/KkBqEp6hD5nuLSvMO29K4wYpWVqGVH2GNW/aidNa9a5gx
        KQUhYxuPXkH/Bmx996UxCgcIHIasXR8BfOZXmVYfXXujFC6+QxTTd02R79bog4xBKQTf+uZ8rVxz2
        8FjrWLXQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pn9al-008pIY-2I;
        Fri, 14 Apr 2023 02:55:15 +0000
Date:   Fri, 14 Apr 2023 03:55:15 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Richard Cochran <richardcochran@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Weirdness with bind mounts and moving files from tmpfs
Message-ID: <20230414025515.GG3390869@ZenIV>
References: <ZDic8fx1NQirB2+d@hoboy.vegasvil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDic8fx1NQirB2+d@hoboy.vegasvil.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 05:23:13PM -0700, Richard Cochran wrote:

> So far, so good.  Now do the same, but with 'mv' instead of 'cp'...
> 
>     # echo three > /run/file
>     # mv /run/file /home/file
>     # cat /opt/file
>     two
> 
> At this point, the contents of /opt/file are stuck forever with "two"...
> 
>     # echo three > /run/file
>     # cp /run/file /home/file
>     # cat /opt/file
>     two
>     # echo three > /home/file
>     # cat /opt/file
>     two
> 
> What is going on here?  Is this a bug or a feature?

strace and compare the traces...  cp(1) opens the existing
target, truncates and writes to it; mv(1) tries rename(),
falling back to unlink()+creat()+write() in case rename()
failed with -EXDEV.

The same behaviour can be seen without any mount(2) use:

; echo x > a
; ln a b
; echo y > c
; cat a
x
; cat b
x
; cat c
y
; cp c a
; cat b
y
; echo x > a
; cat a
x
; cat b
x
; mv c a
; cat a
y
; cat b
x
;

Exact same underlying cause - writing down what happens
step-by-step might be enlightening...
