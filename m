Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF216F6145
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 00:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjECW1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 18:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjECW1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 18:27:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DD27DAC
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 15:27:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF65B62F18
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 22:27:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC53C433D2;
        Wed,  3 May 2023 22:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683152824;
        bh=AVfR9qQTVgZMvpZKp09wG2HIaHnOun4pCekn7lAU86w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s2caT3xqBd3NFp/pjaQsGMYH1qVp2zMvaHK7bjjYKtR8DVy6jO721estVaE1kR1cU
         7UuDl0en/+cm+ADGlDreSBhGzOpguPLXXPNe/D53BJIJHH8YFjS+42JEaGiUy4+qQZ
         318BJ8d22nD5Do0GErf3egdPSgiQF6QdHR/9P9LkVpCMwCEC90GUnuw44Qvixb5pCa
         +A17rcPmofzex65nugMeb+h3Bf1YjjbCzgfqaOXT18gbOnMilAAM/EPqwp1Ke/D4BK
         Jgk020pDX1E1sSUnaPnUSamtCuIQTNUR5AjEmhOc1sr3ZjtvkCk6H7IVpI814IMSCb
         WlX0ZXxg2PrAA==
Date:   Thu, 4 May 2023 00:27:01 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Victor Hassan <victor@allwinnertech.com>, fweisbec@gmail.com,
        mingo@kernel.org, jindong.yue@nxp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tick/broadcast: Do not set oneshot_mask except
 was_periodic was true
Message-ID: <ZFLftU4sEgeEaRJe@lothringen>
References: <20230412003425.11323-1-victor@allwinnertech.com>
 <87sfd0yi4g.ffs@tglx>
 <ZD/uWdz7dKLKlUqH@localhost.localdomain>
 <87jzy42a74.ffs@tglx>
 <ZFDxph8YDPjwvbej@lothringen>
 <87y1m652n2.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1m652n2.ffs@tglx>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2023 at 02:38:57PM +0200, Thomas Gleixner wrote:
> Updated patch below.
> 
> Thanks,

Looks good from my layperson's eyes, just a doubt about a comment below:

> +
> +	/*
> +	 * When switching from periodic to oneshot mode arm the broadcast
> +	 * device for the next tick.
> +	 *
> +	 * If the broadcast device has been replaced in oneshot mode and
> +	 * the oneshot broadcast mask is not empty, then arm it to expire
> +	 * immediately in order to reevaluate the next expiring timer.
> +	 * nexttick is 0 and therefore in the past which will cause the

Is nexttick really in the past? It's set to tick_next_period...

Thanks.

> +	 * clockevent code to force an event.
> +	 *
> +	 * For both cases the programming can be avoided when the oneshot
> +	 * broadcast mask is empty.
> +	 *
> +	 * tick_broadcast_set_event() implicitly switches the broadcast
> +	 * device to oneshot state.
> +	 */
> +	if (!cpumask_empty(tick_broadcast_oneshot_mask))
> +		tick_broadcast_set_event(bc, cpu, nexttick);
>  }
