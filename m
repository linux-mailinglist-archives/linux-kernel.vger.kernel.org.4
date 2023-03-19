Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1197C6C0332
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 17:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjCSQhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 12:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjCSQgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 12:36:51 -0400
Received: from sender11-op-o11.zoho.eu (sender11-op-o11.zoho.eu [31.186.226.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCED0CC38;
        Sun, 19 Mar 2023 09:36:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1679243770; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=TWvfcLdvxEd52WkBg3U/j4DiJl8lCvHmTYCTaXaxvuLIFEsK1Q2CGu2adphLmTN3yuniACFaUGp8ZvE2yd3uxm4l6yOIAUT9NJx+hY+qaF+AQFU5jWn1JKS46A/g3m3+P60M6480Hgu2dYvox0ULTfc/gHigU3EQsbGQjJWOJy4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1679243770; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=1+gnTKfJVBMgMmDYlGD4RzHzJLRW5Xx60pBV+z1t9SQ=; 
        b=fNlvK8g85iV6YtYscore9bLeYEttHcK0wE66ybbzFU/tBEwXEM1AYvdIZKds8+oQaMZoOmWK0JngX5VzeXZgmU/Xn3AQ/J1dU6YVQIczZICHJ5dJ1NV1Eowsy79wCQK1Dx4Mn5f0x3q/SxH02tWJJSoUrdlCv2+Fpi41bVNMp8U=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org>
Received: from [192.168.99.50] (pool-98-113-67-206.nycmny.fios.verizon.net [98.113.67.206]) by mx.zoho.eu
        with SMTPS id 16792437681711020.1266679224117; Sun, 19 Mar 2023 17:36:08 +0100 (CET)
Message-ID: <318ff554-0694-64e1-72bd-d941a775a16f@trained-monkey.org>
Date:   Sun, 19 Mar 2023 12:36:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH - mdadm] mdopen: always try create_named_array()
Content-Language: en-US
To:     NeilBrown <neilb@suse.de>
Cc:     Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        Song Liu <song@kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        linux-raid <linux-raid@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nikolay Kichukov <hijacker@oldum.net>
References: <167875238571.8008.9808655454439667586@noble.neil.brown.name>
From:   Jes Sorensen <jes@trained-monkey.org>
In-Reply-To: <167875238571.8008.9808655454439667586@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/23 20:06, NeilBrown wrote:
> 
> mdopen() will use create_named_array() to ask the kernel to create the
> given md array, but only if it is given a number or name.
> If it is NOT given a name and is required to choose one itself using
> find_free_devnm() it does NOT use create_named_array().
> 
> On kernels with CONFIG_BLOCK_LEGACY_AUTOLOAD not set, this can result in
> failure to assemble an array.  This can particularly seen when the
> "name" of the array begins with a host name different to the name of the
> host running the command.
> 
> So add the missing call to create_named_array().
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217074
> Signed-off-by: NeilBrown <neilb@suse.de>

Applied!

Thanks,
Jes


