Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E2670DA00
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 12:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbjEWKIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 06:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbjEWKIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 06:08:31 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1389594;
        Tue, 23 May 2023 03:08:30 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id A1938EC0FB;
        Tue, 23 May 2023 03:07:59 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KbGcv4xDKMA0; Tue, 23 May 2023 03:07:58 -0700 (PDT)
Message-ID: <73bfe0c438e194fa462bec521debacfcd722dc9e.camel@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1684836478; bh=9EdsnoYppzbz7/Oy1JMJUuNn+Xm2e+YtZle+d/rzbnA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lBCRZv3/sUQneBb+2Iv9lYDq/oFyEHy6IN1G0yoMdJTrIBt2SWEuCqclG00gaWFei
         vuyDxQGXtVcSWoNRQ5J98jPQEZnaTOIc7/gWsjqHhzN5S5gmeEwgHMSZRLX5xgHNkZ
         bWjDCZzfpCRmM6XqRV/HUYqdna4mlRJKYnxB6ZuFrGHj7s5mzNrxMaETUEJEPVHHYf
         OQcRz2RNB9YuCzdgBP3lH7ZhLW3UAj4v1mwBS8WBCfT1rkpEeFwCvivhsyQglgdhS3
         lachoCFeq1bRxCVvZa6i6tWRlcwq1hvIND7OuNBu0I1GeOWO0194p7W+ODWVahzltR
         lPruuQU7aE5Sg==
Subject: Re: [PATCH v2] media: hi846: fix usage of pm_runtime_get_if_in_use()
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     laurent.pinchart@ideasonboard.com, kernel@puri.sm,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mchehab@kernel.org
Date:   Tue, 23 May 2023 12:07:54 +0200
In-Reply-To: <ZGODstToZrypFaAV@valkosipuli.retiisi.eu>
References: <20230425094747.2769693-1-martin.kepplinger@puri.sm>
         <ZGODstToZrypFaAV@valkosipuli.retiisi.eu>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1+deb11u2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, dem 16.05.2023 um 16:22 +0300 schrieb Sakari Ailus:
> Hi Martin,
> 
> On Tue, Apr 25, 2023 at 11:47:47AM +0200, Martin Kepplinger wrote:
> > pm_runtime_get_if_in_use() does not only return nonzero values when
> > the device is in use, it can return a negative errno too.
> > 
> > And especially during resuming from system suspend, when runtime pm
> > is not yet up again, -EAGAIN is being returned, so the subsequent
> > pm_runtime_put() call results in a refcount underflow.
> > 
> > Fix system-resume by handling -EAGAIN of
> > pm_runtime_get_if_in_use().
> > 
> > Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> > ---
> > 
> > revision history
> > ----------------
> > v2 (thank you Sakari and Laurent):
> > * drop the other patch (the streaming-state in suspend/resume needs
> > to
> >   be solved differently).
> > * Sakari pointed out that many drivers are affected by this and
> > that
> >   runtime-pm might need changes instead. I think this patch doesn't
> > hurt
> >   and could serve as a reminder to do so.
> 
> I guess it's appropriate to add:
> 
> Fixes: e8c0882685f9 ("media: i2c: add driver for the SK Hynix Hi-846
> 8M pixel camera")
> 

I agree. Feel free to do so when applying.

                            martin


