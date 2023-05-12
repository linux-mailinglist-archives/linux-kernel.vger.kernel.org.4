Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61EE56FFF66
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 05:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239866AbjELDpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 23:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239844AbjELDpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 23:45:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B195FC1;
        Thu, 11 May 2023 20:45:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C81264EB2;
        Fri, 12 May 2023 03:45:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8FFC433EF;
        Fri, 12 May 2023 03:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1683863114;
        bh=sX6OHxSqG3kE9RNh5irNxZVSLex4+GvWgeSM0qb5IHY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F0+fImXh1fMEWRvhKuXlhkds/fjnoJHELMaOLXJjBzLBVmOiQm/zS+3pHZXyr2jhg
         bnJ4XSjB/OAwuB4R4AvTIdAXHD5HMCjkLgqXwuVO2UmNM474rjY/uE745m5FAZK4tE
         N1a7b/oshU3BtAr7ZazeFwMh5T8+oDePLCwD8xNU=
Date:   Thu, 11 May 2023 20:45:13 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/2] statfs: Enforce statfs[64] structure intialization
Message-Id: <20230511204513.3d0d60f0315350177a800284@linux-foundation.org>
In-Reply-To: <20230504144021.808932-2-iii@linux.ibm.com>
References: <20230504144021.808932-1-iii@linux.ibm.com>
        <20230504144021.808932-2-iii@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  4 May 2023 16:40:20 +0200 Ilya Leoshkevich <iii@linux.ibm.com> wrote:

> s390's struct statfs and struct statfs64 contain padding, which
> field-by-field copying does not set. Initialize the respective structs
> with zeros before filling them and copying them to userspace, like it's
> already done for the compat versions of these structs.
> 
> Found by KMSAN.
> 

Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
