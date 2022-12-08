Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5D4647A58
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 00:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiLHXvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 18:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiLHXvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 18:51:10 -0500
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB96786A6
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 15:51:08 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 08F20C01F; Fri,  9 Dec 2022 00:51:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1670543477; bh=QUvoOJxMSTsrot0jUwJ6h/lLkW+XnJ1Zn8GsM7vrCDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DwqLL9wgKZDl3JKJi/jRHU+a7DKx6d/t+5k2fymUUk2l+DqkwYLEQcqWqARep/jZk
         zxhjmq96tijquqm31YzR5iocJzSlVDEBNi6ioPi5NJcigwqL/R3mWMsYLFRD/x5FSz
         ZKNDuT+txvOFufVJZTCT7lZIGrG43IwKN/FaaadXT/XtAOkclI1kClaJ+GyVZs4A+X
         EcTFy2Od57Q4vvbtcdQXa2/7G+9tndTLmlirD0s+NAbqyoZtmE2v5zZdqyyPtgryBh
         W+9h0GKeQqBrGRNbe7RO17dj9msRD3y7FGw4wRhGpHlai3a+7Y8ib8ofGLpqDADBxe
         yS5ZxIa3HWnOA==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id BA557C01B;
        Fri,  9 Dec 2022 00:51:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1670543476; bh=QUvoOJxMSTsrot0jUwJ6h/lLkW+XnJ1Zn8GsM7vrCDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XYHMzXYqGnkharO6IuJq1hzrX3JD6HJ4sJ2r1jS3IKdJpTpa8YI2pEspYu7ZaLo8r
         lpCRdfdPOd0KxG47IcxY62b+KdsXieU6JB7U9sfQbE1llp1vg2Jcacj+DRU99X6J5p
         NlP2QpPxLeuMLqaZRlG0t4RSPqOawzDL7T+LBpjb++nhgB444AWtQk8j+KIagldtAa
         gDrRyhRgIuLWLB/YYUiaqoml6SlQuSjw/8vlTGiIHzWx10NjUenktCsMKdjWGGORoL
         MEsyQwq24cwdtpAIy++mjyQZtXz+W8ZA+VPL9B3fUtxgVolSZv76/OJGnyowbFGkg/
         jtO6h2NOieW2A==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 168aa860;
        Thu, 8 Dec 2022 23:51:01 +0000 (UTC)
Date:   Fri, 9 Dec 2022 08:50:46 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH] 9p/client: fix data race on req->status
Message-ID: <Y5J4Voie1ik6BqnR@codewreck.org>
References: <20221205124756.426350-1-asmadeus@codewreck.org>
 <3368929.hG1Ktuj5m1@silver>
 <Y45wZEvO8gOanV85@codewreck.org>
 <167052961.MU3OA6Uzks@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <167052961.MU3OA6Uzks@silver>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Schoenebeck wrote on Thu, Dec 08, 2022 at 04:51:27PM +0100:
> Right, looks like most of it should be fine. Maybe p9_client_zc_rpc() needs a
> barrier as well?

Good point, the request is used without any other lock after the
wait_event on req->status in trans_virtio.c;
I'll send a separate patch for it later today.


> > I think we're just protecting against compiler
> > reordering or if on some arch the store isn't actually atomic.
> 
> And access order within the same thread.

In this case afaik the barrier also does that? There would be no point
if a write barrier allowed a write placed before the barrier to be
reordered after it...

> > This code path actually was broken before I added the barrier a while
> > ago (2b6e72ed747f68a03), as I was observing some rare but very real
> > errors on a big server so I'm fairly confident that for at least x86_64
> > the generated code isn't too bad, but if KCSAN helps catching stuff I
> > won't complain.
> 
> What about p9_tag_alloc()?

I think that one's ok: it happens during the allocation before the
request is enqueued in the idr, so it should be race-free by defition.

tools/memory-model/Documentation/access-marking.txt says
"Initialization-time and cleanup-time accesses" should use plain
C-language accesses, so I stuck to that.

cheers,
-- 
Dominique
