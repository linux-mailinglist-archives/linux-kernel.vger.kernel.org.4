Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6228D633A77
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbiKVKs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbiKVKsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:48:01 -0500
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDE52600
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=n8rOvLnkpr7DU4/g+Ojdkm89PZHuDF2laztQuxOpyCI=; b=lpWTvJ3v5Va4Mt6qKKjEdQ08qC
        pCLdCeTc/pJMUuHkSbDybeq8lVRBQGuRvxVvJuyLnGVECKmdbUKLiadFAiRUGZInxM4d3vWlEQcgj
        c8UzV9kJN9mMMaDwkRgS7oF0AAjM/PFFK4UGcoB67QIiCREXE17WeMJC+mbx9edCmQRee4xaxP/3B
        3QJ/TryXBGJm610Ilr4ndx1TRLZevHVRhN1hI097ZU/JWGhcPpgvlA+tGwioI/wI9XpYTsiKMfg3Q
        sTsfGPXYNcfiHZDrHBpMPRm5QXQwj7ZLYvhzLlc8QFTO05IdEB7vo4CQ+vN53OL3qvZmR71+84Uvq
        LuWN9kDK6D5ognMMybyCN7EvDdD15uo6KpEkS7pFysYXyh6/Cfp+OtX51/V6RuAHjZhT6taEwRwZg
        g9QobxjQR1Wb8+Lvl9aEUuRyYvGw25jzEnJa4APJfXrnVVto/HdvjDA0TE5Yi19LOLjkTtHmr58N0
        dKtgYNC26090VksegOCTK3oJ5U9562vFuuyA3/B95+8GVMriny2Yz4BtV+oea2X/WFty7ZLXZhmFF
        tjZMhWE7+58TshFnaBTdQJafN8imr7ylAHLJTRSeKtBj9uhN8pshSNv7ferWpt3TzdlOuup5O03K7
        Al4U3tDCppEDyXhaWEgemHEFAkmgEKTU1QktQbyfY=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        GUO Zihua <guozihua@huawei.com>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] 9p/xen: check logical size for buffer size
Date:   Tue, 22 Nov 2022 11:46:13 +0100
Message-ID: <2955638.xlpIv7zoH0@silver>
In-Reply-To: <Y3waS1oq4BmitGLT@codewreck.org>
References: <20221118135542.63400-1-asmadeus@codewreck.org> <37091478.n1eaNAWdo1@silver>
 <Y3waS1oq4BmitGLT@codewreck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, November 22, 2022 1:39:39 AM CET Dominique Martinet wrote:
> Christian Schoenebeck wrote on Mon, Nov 21, 2022 at 05:35:56PM +0100:
> > Looks good (except of s/rreq/req/ mentioned by Stefano already).
> 
> Thanks for the review (I've taken this as a 'reviewed-by' under the
> assumption of that fix, sorry for being a bit aggressive at collecting
> these -- I'd rather overcredit work being done than the other way around)

Yes, you can add my RB of course!

> I'll send this and the three other commits in my 9p-next branch to Linus
> tomorrow around this time:
> https://github.com/martinetd/linux/commits/9p-next
> 
> 
> > >  		memcpy(&req->rc, &h, sizeof(h));
> > 
> > Is that really OK?
> > 
> > 1. `h` is of type xen_9pfs_header and declared as packed, whereas `rc` is 
of 
> >    type p9_fcall not declared as packed.
> > 
> > 2. Probably a bit dangerous to assume the layout of xen_9pfs_header being 
in
> >    sync with the starting layout of p9_fcall without any compile-time 
> >    assertion?
> 
> I've done this in a follow up that will be sent to Linus later as per
> Stefano's suggestion.

Great, one patch less to send, thanks! :)


