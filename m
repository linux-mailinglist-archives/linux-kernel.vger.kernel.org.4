Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573066ADB3B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 10:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjCGJ6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 04:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjCGJ6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:58:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64E96182
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 01:58:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8FFE2B81614
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 09:58:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5EEC433EF;
        Tue,  7 Mar 2023 09:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678183108;
        bh=sDlxDfyCDf2Nsy8cDhuVRK8QWFdXPzdnF8Ox4Y4IXNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bt5J74ORJao3gcjb2COM69ODwvdCnvNC3aioZv5uBIIMqZmf5JiFWKCmPsXY01rO6
         ve+/s5vOJXoamhb/xqPWxXLunwIT55Jt/FYlpkfZ4BD6iynPLZUYhLcUp4UUDMBVV4
         D3D6dBkF+iKpBVhq5fWKxQkHYao63rBxYxoEz83Q=
Date:   Tue, 7 Mar 2023 10:58:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xia Fukun <xiafukun@huawei.com>
Cc:     prajnoha@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kobject: Fix global-out-of-bounds in
 kobject_action_type()
Message-ID: <ZAcKwV4if7/1dCZV@kroah.com>
References: <20230307063757.247430-1-xiafukun@huawei.com>
 <ZAby1q1kA71S2WCv@kroah.com>
 <396e6a21-5270-1624-1229-1e59701cce35@huawei.com>
 <ZAcDlAkujTLkbrqr@kroah.com>
 <50e3be73-5fb1-0505-6ddb-422cee6e466b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50e3be73-5fb1-0505-6ddb-422cee6e466b@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 05:49:25PM +0800, Xia Fukun wrote:
> I know how to modify it to meet your requirements:

Again, please stop top-posting, as I can't follow what you are trying to
do here at all otherwise.

> 
> 	for (action = 0; action < ARRAY_SIZE(kobject_actions); action++) {
> 		if (strncmp(kobject_actions[action], buf, count_first) != 0)
> 			continue;
> 		if (strlen(kobject_actions[action]) > count_first)
> 			continue;
> 		if (args)
> 			*args = args_start;
> 		*type = action;
> 		ret = 0;
> 		break;
> 	}
> 
> So I will modify the patch and resubmit it. Please review it again

Please test your change and submit it and then I will add it to my
review queue like everything else I get :)

But again, this whole function feels very fragile, shouldn't it be
rewritten to be more clear?

thanks,

greg k-h
