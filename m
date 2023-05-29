Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF9F7150A4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 22:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjE2Uka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 16:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjE2Uk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 16:40:28 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D427CF;
        Mon, 29 May 2023 13:40:23 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (82-181-192-243.bb.dnainternet.fi [82.181.192.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4QVS8F0NKSz49Psb;
        Mon, 29 May 2023 23:40:12 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1685392814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aKrMmJS6UFOXWpnJtPQFVZKoxYuel7ujkpy1v5Vq8JY=;
        b=TfBz/lgOpq6E9nccbfdJWVwBfkD2kgapf2d/WOqzWHo9xbsp/gLTdL3G2sukmSw72BDzMr
        4HJjrnODO/HP3+EOZTo+uyGAaI9NWzU7KzzZRcQ3eIQ26zNVW5xMiMal3ri/9O10bKvz2q
        7IHOaRcyCqNGZbvPGiHE7qeyVlEYsQvVhel4emet+nvu9IT0kDJZWzLABdC/vq2VxcKOVm
        Buv2WBZIO/2f0MBkQm89rIDKleQnxdIzRItuba4M23ZzCKw5N2d/TyVV0o+IJZADQacUjD
        WH2tKXL/xr7BnTL9jX0MqtR9aEqSWcydvr/rWgK4j6f67dXfwRLvSMuryDSsxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1685392814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aKrMmJS6UFOXWpnJtPQFVZKoxYuel7ujkpy1v5Vq8JY=;
        b=sN4R+xtS7GAfoIDci2Snn9cc27sf2G6dm050Exb1/wEh0YaJOmX3OSbH8ptYA2aIU6b+8o
        DIw9casC8lK8LFFl0YEws5+rna+piQyTghXT20AWVuSK+QqzmeR04XvUg2CfgozHxyg71a
        RxvSH0qQ6lUnSbBPd7BAOVcQv/E4FNurphmRDLtuyjoRLqnbXuouDOeYi85V7K9wLrAH7g
        suFe68XhMVAZM3SB239kW2vvelfGkkoWx3GXKjQq6OB7B0/FE4LA3whoTLIfbTVM0Lof1U
        tRm+YjZLb2I0AmhR1a2m568C33jaC0LmMOfSlrrwzw2t1zCukKkjheec9koxMg==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1685392814; a=rsa-sha256;
        cv=none;
        b=olTBHGB30pHxL93soLi1eo1qm+qT0xws3OLlvGXQ/efEHIuFkg+CMUVDI+QoHhjRbbHw5q
        4vaFKyJ4ySzkYZh/ShO2IsUf0LknViVefbrlFy5vvnEAIZ8eOlElV+qCxv2k6EwH+3TlG3
        p1B7YyrIdtxLUfhAFpT37Xco0G6gDj1539J6w+w0v3OsU8Dw6KND3Per7mOnqjE41grAIc
        rn7ewpJwXdX3uFZhv2INNwo/fFvpyYkGU6b5KXO6z+V9KRCWnzY4hWi3+c8sNL3QApwkzO
        IFhirlDJbTDZkg2qHE4ESFURXhFOBV3XEhJaY8rnTQOHSpeyCBd8mJ2BV3HNMg==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 6A275634C91;
        Mon, 29 May 2023 23:40:12 +0300 (EEST)
Date:   Mon, 29 May 2023 23:40:12 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     laurent.pinchart@ideasonboard.com, kernel@puri.sm,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mchehab@kernel.org
Subject: Re: [PATCH v2] media: hi846: fix usage of pm_runtime_get_if_in_use()
Message-ID: <ZHUNrHGJv63mKGH0@valkosipuli.retiisi.eu>
References: <20230425094747.2769693-1-martin.kepplinger@puri.sm>
 <ZGODstToZrypFaAV@valkosipuli.retiisi.eu>
 <73bfe0c438e194fa462bec521debacfcd722dc9e.camel@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <73bfe0c438e194fa462bec521debacfcd722dc9e.camel@puri.sm>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 12:07:54PM +0200, Martin Kepplinger wrote:
> Am Dienstag, dem 16.05.2023 um 16:22 +0300 schrieb Sakari Ailus:
> > Hi Martin,
> > 
> > On Tue, Apr 25, 2023 at 11:47:47AM +0200, Martin Kepplinger wrote:
> > > pm_runtime_get_if_in_use() does not only return nonzero values when
> > > the device is in use, it can return a negative errno too.
> > > 
> > > And especially during resuming from system suspend, when runtime pm
> > > is not yet up again, -EAGAIN is being returned, so the subsequent
> > > pm_runtime_put() call results in a refcount underflow.
> > > 
> > > Fix system-resume by handling -EAGAIN of
> > > pm_runtime_get_if_in_use().
> > > 
> > > Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> > > ---
> > > 
> > > revision history
> > > ----------------
> > > v2 (thank you Sakari and Laurent):
> > > * drop the other patch (the streaming-state in suspend/resume needs
> > > to
> > >   be solved differently).
> > > * Sakari pointed out that many drivers are affected by this and
> > > that
> > >   runtime-pm might need changes instead. I think this patch doesn't
> > > hurt
> > >   and could serve as a reminder to do so.
> > 
> > I guess it's appropriate to add:
> > 
> > Fixes: e8c0882685f9 ("media: i2c: add driver for the SK Hynix Hi-846
> > 8M pixel camera")
> > 
> 
> I agree. Feel free to do so when applying.

Done!

-- 
Sakari Ailus
