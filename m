Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD7B704F23
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbjEPNXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbjEPNXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:23:03 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7CE3AB3;
        Tue, 16 May 2023 06:23:02 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (dkzdf0gkyyyyyyyyyyyyt-3.rev.dnainternet.fi [IPv6:2001:14ba:4506:4f15::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4QLH3l0qd8z49Q1p;
        Tue, 16 May 2023 16:22:58 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1684243379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LYm57qahGGnGyquSeF8WyCiLIi8u6txp9tP3SjIBVTw=;
        b=MU6ytvkX52s5uFd0p3Hy/kf3FZkvW7cKx4G6DvS1iwDcY60EB2y5nUpCAMKtP+AYbE5Zo5
        GXnAfGhn4BtSB52ZM2uskRXMJ+Kh/T1KZzLC/+aTUyQ9qNrvXkGgc120kPUffQqWyoXggg
        W6PVcFwWxVr0JPkhVzGjN9FgIyZNkOa1DotWC2QNsmi72knXprL65CBWDeOWe5omFgOWeE
        eE6Xj58DBR6ZLD02Da0LZBL+OlrRgTamO/Sb72BWcUN6LQODsOlGGFwfN7UNnYXa3QdGup
        R7FbMeAoizdnAnRnwy4ls8h2a/thBSCrr2N3JP20XrkgmUBELyzUNuSsszLQIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1684243379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LYm57qahGGnGyquSeF8WyCiLIi8u6txp9tP3SjIBVTw=;
        b=iiRFHT4jQEI+LyJ+lREDpZb6PtTRwio98/d6DcNUElpriL91+tJMfDdQzilLFB3AJlNAX+
        fv2u0mo+XructYA8sUl4RdE1aN4Yd66uhlyzg3uZJRd3exm+/7L8JOqh9WlqvtGXrdGfGb
        tx34ytvWyAtbsw7nb+bq4NMAhjVLN8hCyVTuFO6FODOaPZy82mmIiQ5qONbAM6BI/odtcQ
        DKVHxCRTpC/ltYxuWoManZ5h8ibA2CpRN5CfofT9IC0VnibZVWDiYUIXUcbiUA4kv5NHZ0
        rxge4uRTjXXUYiQnLbe+FpWTIHh386lP3Cdb94VERJV5BdQo/nQQ6MIlD+6ipA==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1684243379; a=rsa-sha256;
        cv=none;
        b=e9PO1Aqdbm6rrqVrTK/wADmjy0CT6A3O9RritwAHM0jj5D86mPxEFmrq9t0ACjAKEx/A8H
        2njMTpo+ngpOPALLb3W1M3GICuXPZKYRGvceXiQRnRzSbEMwVHUfVWRzRwVsYAWFrA1rVB
        T0hHcAtbM7H+zpwYWu4iPQBUmrPmjm0Xvlgs0zSlssgTPONzSUVVA3AHTT8feZhW7UBUpK
        Z4HDOKxjpLzkrpInL+4t2wvcwk4jJF4BRGabieNTzOpQLXhiFC9jAsrU9KmdocTkHRSk7W
        6AOht2fHhbu1pP3GZxvPGh2W3GKsI6lJCdSMeCxQPAYdTV+JIqHKGoV3856PRQ==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 7C65E634C96;
        Tue, 16 May 2023 16:22:58 +0300 (EEST)
Date:   Tue, 16 May 2023 16:22:58 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     laurent.pinchart@ideasonboard.com, kernel@puri.sm,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mchehab@kernel.org
Subject: Re: [PATCH v2] media: hi846: fix usage of pm_runtime_get_if_in_use()
Message-ID: <ZGODstToZrypFaAV@valkosipuli.retiisi.eu>
References: <20230425094747.2769693-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425094747.2769693-1-martin.kepplinger@puri.sm>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Tue, Apr 25, 2023 at 11:47:47AM +0200, Martin Kepplinger wrote:
> pm_runtime_get_if_in_use() does not only return nonzero values when
> the device is in use, it can return a negative errno too.
> 
> And especially during resuming from system suspend, when runtime pm
> is not yet up again, -EAGAIN is being returned, so the subsequent
> pm_runtime_put() call results in a refcount underflow.
> 
> Fix system-resume by handling -EAGAIN of pm_runtime_get_if_in_use().
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
> 
> revision history
> ----------------
> v2 (thank you Sakari and Laurent):
> * drop the other patch (the streaming-state in suspend/resume needs to
>   be solved differently).
> * Sakari pointed out that many drivers are affected by this and that
>   runtime-pm might need changes instead. I think this patch doesn't hurt
>   and could serve as a reminder to do so.

I guess it's appropriate to add:

Fixes: e8c0882685f9 ("media: i2c: add driver for the SK Hynix Hi-846 8M pixel camera")

-- 
Sakari Ailus
