Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A63E600491
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 02:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiJQAlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 20:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiJQAkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 20:40:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931A1360B7
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 17:40:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21899B80D5B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 00:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98BAC433C1;
        Mon, 17 Oct 2022 00:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1665967233;
        bh=DdTOCukEn0G9bfVE8ZyKClnyxvtSZtfh7HrKBPqPF/0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oqlrAv/YTMgHHkJBw3hrVCRXayWG27j3E9uGvj7sJ1WkEoQMzPESwg+y2HgOvfMMN
         bfvYRQubOz3YUcHUck/9/I9GZoDGBpCG74EgkcmZwgoFplDxGvaoQu/dhEiXRPeXXQ
         rCNLS5MNSFBYDYeiYNUjDz5v1MXGIcwPDByqFQNQ=
Date:   Sun, 16 Oct 2022 17:40:33 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     Martin =?UTF-8?B?TGnFoWth?= <mliska@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gcov: support GCC 12.1 and newer compilers
Message-Id: <20221016174033.d33a998b4c91b7d18b3dc310@linux-foundation.org>
In-Reply-To: <581f6037-ff43-4f91-cabf-d9aa0d72bbe6@linux.ibm.com>
References: <624bda92-f307-30e9-9aaa-8cc678b2dfb2@suse.cz>
        <581f6037-ff43-4f91-cabf-d9aa0d72bbe6@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Oct 2022 11:30:51 +0200 Peter Oberparleiter <oberpar@linux.ibm.com> wrote:

> On 13.10.2022 09:40, Martin Liška wrote:
> > Starting with GCC 12.1, there are 2 significant changes to the .gcda
> > file format that needs to be supported:
> > 
> > a) [gcov: Use system IO buffering] (23eb66d1d46a34cb28c4acbdf8a1deb80a7c5a05) changed
> >    that all sizes in the format are in bytes and not in words (4B)
> > b) [gcov: make profile merging smarter] (72e0c742bd01f8e7e6dcca64042b9ad7e75979de)
> >    add a new checksum to the file header.
> > 
> > Tested with GCC 7.5, 10.4, 12.2 and the current master.
> > 
> > Signed-off-by: Martin Liska <mliska@suse.cz>
> 
> Looks good, thanks! I successfully tested this patch on s390 using GCC
> 12.2 and 11.2.
> 
> Tested-by: Peter Oberparleiter <oberpar@linux.ibm.com>
> Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
> 
> Andrew, could you add this patch via your tree?

Sure.

The changelog doesn't tell us what the user-visible effects of this are
(please, it should do so), but it sounds to me like those effects are
"gcov is utterly busted".

So I'll add a cc:stable to this, so that people can use new gcc
versions to build older kernels.
