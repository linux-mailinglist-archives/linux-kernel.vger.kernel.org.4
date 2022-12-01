Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D1363F1F4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 14:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbiLANr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 08:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiLANrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 08:47:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4C425E9F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 05:47:50 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669902467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JE0fhHfH7VWLK3JbBcGwJPNOe7/dfPlHGpiWVNcwUNU=;
        b=qgFQOJUyPhr6v/eff/0V5ZPaFfPpGAXzyCfMMlCRFZhHoq8CfyitjTxfXiNummCaCMHMGs
        oYUvZPfDKTHbb6ptzkAyz8Kt+R9S07mNr2N5fiCJmKNy/3NznQL/g7wB5gyLpY0/UadOx5
        GoB8oGTQNdHpHcTu6k3NDX/bnHMLSQ9+vbQfV4BA8s/PsUeShpiowDM2gVbbuy1kIJxic7
        dUROpAlVt/PiSNUJ+KzrHFPvMjrKLWWy60EcVIqjs0YRh6uDmTUR4aqtxGoGmgVHpk/yoY
        ovW4gAMWxydq9Wc6JascjbiWYHOAcyXoDkorGQ2v62cEK7XT5w0J58BN9Kl7RA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669902467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JE0fhHfH7VWLK3JbBcGwJPNOe7/dfPlHGpiWVNcwUNU=;
        b=zeCHvasjzIxIzlHs7BeB3QWlSpv1LlC8GXs5M83XfEMJp7d4bt3IaU+So/MdS3ZbD1y60P
        MLJ4nEnpXUCKilAw==
To:     Jacob Macneal <jake.macneal@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     jake.macneal@gmail.com, John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] time: copy tai value (International Atomic Time, in
 seconds) to output __user struct in get_old_timex32().
In-Reply-To: <20221121055345.111567-1-jake.macneal@gmail.com>
References: <20221121055345.111567-1-jake.macneal@gmail.com>
Date:   Thu, 01 Dec 2022 14:47:46 +0100
Message-ID: <877czbs0al.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jacob!

On Mon, Nov 21 2022 at 00:53, Jacob Macneal wrote:
> Previously, this value was not copied into the output struct.

Previously has no meaning here.

> This is despite all other fields of the corresponding __kernel_timex
> struct being copied to the old_timex32 __user struct in this function.

This is completely backwards. get_old_timex32() copies from the user
supplied old_timex32 struct to the __kernel_timex struct, no?

> Additionally, the matching function put_old_timex32() expects a tai
> value to be supplied, and copies it appropriately. It would appear to
> be a mistake that this value was never copied over in
> get_old_timex32().

Sure, but the important point is that txc->tai is never used as input
from userspace. It's only ever used as output to userspace, which
explains why this never caused any functional issue.

I'm not against this change per se, but the justification for it really
boils down to:

      Make it consistent with the regular syscall

Thanks,

        tglx
