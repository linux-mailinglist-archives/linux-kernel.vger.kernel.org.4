Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EE963BBC4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 09:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbiK2IfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 03:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiK2Ieg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 03:34:36 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C40C59877;
        Tue, 29 Nov 2022 00:33:09 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 65BAA68AFE; Tue, 29 Nov 2022 09:33:06 +0100 (CET)
Date:   Tue, 29 Nov 2022 09:33:06 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jinlong Chen <nickyc975@zju.edu.cn>
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] elevator: replace continue with else-if in
 elv_iosched_show
Message-ID: <20221129083306.GB24762@lst.de>
References: <cover.1669391142.git.nickyc975@zju.edu.cn> <852b18c086ef08baec99d08479a3558a3d5db70f.1669391142.git.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <852b18c086ef08baec99d08479a3558a3d5db70f.1669391142.git.nickyc975@zju.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 11:53:12PM +0800, Jinlong Chen wrote:
>  	list_for_each_entry(e, &elv_list, list) {
> -		if (e == cur) {
> +		if (e == cur)
>  			len += sprintf(name+len, "[%s] ", cur->elevator_name);
> -			continue;
> -		}
> -		if (elv_support_features(q, e))
> +		else if (elv_support_features(q, e))
>  			len += sprintf(name+len, "%s ", e->elevator_name);

Looks good.  But to make this even more obvious I'd also switch to
pinting e->elevator_name for the cur case instead of cur.
