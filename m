Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039B1664CB6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 20:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjAJTm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 14:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjAJTmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 14:42:55 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AD2DEB3;
        Tue, 10 Jan 2023 11:42:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5D939CE1915;
        Tue, 10 Jan 2023 19:42:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67763C433D2;
        Tue, 10 Jan 2023 19:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673379770;
        bh=hGtaGIPAXue2SWqrVUKOJb5N9f2BU0xBHFp1IOuqWE8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ab5EgdBuKEEuwRCfz7B1iDNjIcdEu4Zn4ZrEGqSl41+Eo3pbVP6SDtNc8JptefZs/
         RzMh9K9kshc+8Y7J5yoeBtrOltCq+gumFXAqwYuGsAwflbJ1N8ki/Scd9byMpNNDLI
         ivuEhIGaCKP3W8AqqUXCdgvMysPb+PGqw/FrZg9gIxvlZMTlmHzJMIad3p+hLbUM8I
         6lBAnRcGbzNOwauCoWHRX73YxMz1n8KuprKgmDRnD6d99p60pPCz1G1U2gDm8sCzyL
         ILAi6zjfn7pllsLnCBLdAWoEQ9ukdXXAWLjUxJ2UmZxdRB7VzQez9HxvkiOzFYMQd6
         X6BCYTT3qcULA==
Date:   Tue, 10 Jan 2023 13:42:57 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH][next] drm/i915/guc: Replace zero-length arrays with
 flexible-array members
Message-ID: <Y72/wTm7eIIylTqf@work>
References: <Y72WBTUmh9r1lvKN@work>
 <Y728SwYZeThQzohb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y728SwYZeThQzohb@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 02:28:11PM -0500, Rodrigo Vivi wrote:
> 
> On Tue, Jan 10, 2023 at 10:44:53AM -0600, Gustavo A. R. Silva wrote:
> > Zero-length arrays are deprecated[1] and we are moving towards
> > adopting C99 flexible-array members, instead. So, replace zero-length
> > arrays in a couple of structures (three, actually) with flex-array
> > members.
> > 
> > This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> > routines on memcpy() and help us make progress towards globally
> > enabling -fstrict-flex-arrays=3 [2].
> > 
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays [1]
> > Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [2]
> > Link: https://github.com/KSPP/linux/issues/78
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> > ---
> >  drivers/gpu/drm/i915/gt/uc/guc_capture_fwif.h | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/gt/uc/guc_capture_fwif.h b/drivers/gpu/drm/i915/gt/uc/guc_capture_fwif.h
> > index 3624abfd22d1..9d589c28f40f 100644
> > --- a/drivers/gpu/drm/i915/gt/uc/guc_capture_fwif.h
> > +++ b/drivers/gpu/drm/i915/gt/uc/guc_capture_fwif.h
> > @@ -73,7 +73,7 @@ struct guc_debug_capture_list_header {
> >  
> >  struct guc_debug_capture_list {
> >  	struct guc_debug_capture_list_header header;
> > -	struct guc_mmio_reg regs[0];
> > +	struct guc_mmio_reg regs[];
> >  } __packed;
> >  
> >  /**
> > @@ -125,7 +125,7 @@ struct guc_state_capture_header_t {
> >  
> >  struct guc_state_capture_t {
> >  	struct guc_state_capture_header_t header;
> > -	struct guc_mmio_reg mmio_entries[0];
> > +	struct guc_mmio_reg mmio_entries[];
> >  } __packed;
> >  
> >  enum guc_capture_group_types {
> > @@ -145,7 +145,7 @@ struct guc_state_capture_group_header_t {
> >  /* this is the top level structure where an error-capture dump starts */
> >  struct guc_state_capture_group_t {
> >  	struct guc_state_capture_group_header_t grp_header;
> > -	struct guc_state_capture_t capture_entries[0];
> > +	struct guc_state_capture_t capture_entries[];
> 
> Please notice we are currently using sizeof(struct ...).

Yep; I noticed that. :)

> Along with your proposed changes, shouldn't we also start using
> the struct_size() which already take the flexible array into account?

Not necessarily. In recent times, we don't include the struct_size
changes in the same patch as the flex-array transformation. That's
usually a follow-up patch.

--
Gustavo
