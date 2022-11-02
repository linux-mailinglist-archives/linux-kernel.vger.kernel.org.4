Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1636172A3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 00:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiKBXaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 19:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbiKBX3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 19:29:45 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0015C19C17
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 16:22:59 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id l2so271981pld.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 16:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AdoFh8YVkv5zUPXXAnzyzyEOTwd2Q0UanZEkn/ydxvw=;
        b=j+g0ow4na4Oo4d9VS2DhHEabxP+3YX8dGdUXf69heIBe5MasAqMyAVtyc/55oXxFsl
         keJ8Naw/uZFcKMhItnWoCg1ZRoBANiS+ulRBy6DvzVCKoLcXp7Qbc1I/IMqHMUy48GgK
         29kf/jymVZAiWD/8o1z6wCWdxrcwJpVf9TgUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdoFh8YVkv5zUPXXAnzyzyEOTwd2Q0UanZEkn/ydxvw=;
        b=47+pgy6Pu+miSjgpB3IMnu65XkBEvzTfPrlFnGwai3DxHyXVn+DNznf4ELKSH8JK5f
         Ejvaa4D7uD/k/vVxjlkrNaRxwutWTivn/+CYZHKyp85yreoMhuLJ5V+jywAfhKhqcmyN
         QzJPZy9cTQ+ze1yCyYftpNFHBWGo0jqFmbt2tOoxnMZ3M0V80wU5EtfP5nEiHto0i8+F
         TOcpk3NtSyLLcHKFDdkSyHeKyJbYZmjPHnw9Vu4A6nG/iZN/0/Aohju9hqrbweBL4s6K
         9dxpfcauTfsM7LFrMpIevZpjkgNvkiGxdDzkm7A3HrnlzNdpBUB3XMFCD1FS1ak8IzUk
         8WlA==
X-Gm-Message-State: ACrzQf31CZzG4W9rqX+pklOxMT+C1DgyKLNPDBYRN88/5BvLQXd10KWy
        JdAEDXi39nCyWWOzohlHJ1Pd3Q==
X-Google-Smtp-Source: AMsMyM4JtgQhibbMD7ppeuCJgVgRX+k/QVskw2MC6WOXTO1ktCkcW6tWpFxpS30oJibYAYYYsnDRqA==
X-Received: by 2002:a17:90b:1982:b0:212:fe7f:4a49 with SMTP id mv2-20020a17090b198200b00212fe7f4a49mr45691324pjb.156.1667431353734;
        Wed, 02 Nov 2022 16:22:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p10-20020a17090a348a00b0020d9df9610bsm1994104pjb.19.2022.11.02.16.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 16:22:33 -0700 (PDT)
Date:   Wed, 2 Nov 2022 16:22:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Julien Panis <jpanis@baylibre.com>,
        David Lechner <david@lechnology.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 1/4] counter: Adjust final parameter type in function and
 signal callbacks
Message-ID: <202211021621.34241DC39@keescook>
References: <20221102172217.2860740-1-nathan@kernel.org>
 <202211021216.FF49E84C69@keescook>
 <Y2LR13xrrauVmeXP@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2LR13xrrauVmeXP@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 01:23:51PM -0700, Nathan Chancellor wrote:
> On Wed, Nov 02, 2022 at 12:21:23PM -0700, Kees Cook wrote:
> > On Wed, Nov 02, 2022 at 10:22:14AM -0700, Nathan Chancellor wrote:
> > > The ->signal_u32_read(), ->count_u32_read(), and ->count_u32_write()
> > > callbacks in 'struct counter_comp' expect the final parameter to have a
> > > type of 'u32' or 'u32 *' but the ops functions that are being assigned
> > > to those callbacks have an enumerated type as the final parameter. While
> > > these are compatible from an ABI perspective, they will fail the
> > > aforementioned CFI checks.
> > > 
> > > Adjust the type of the final parameter in the ->signal_read(),
> > > ->function_read(), and ->function_write() callbacks in 'struct
> > > counter_ops' and their implementations to match the prototypes in
> > > 'struct counter_comp' to clear up these warnings and CFI failures.
> > 
> > I don't understand these changes. Where do 'struct counter_comp'
> > and 'struct counter_ops' get confused? I can only find matching
> > ops/assignments/calls, so I must be missing something. This looks like
> > a loss of CFI granularity instead of having wrappers added if there is
> > an enum/u32 conversion needed somewhere.
> 
> Right, I am not the biggest fan of this change myself and it is entirely
> possible that I am misreading the warnings from the commit message but I
> do not see how
> 
>         comp_node.comp.signal_u32_read = counter->ops->signal_read;
> 
> and
> 
>         comp_node.comp.count_u32_read = counter->ops->function_read;
> 
> in counter_add_watch(),
> 
>         comp.signal_u32_read = counter->ops->signal_read;
> 
> in counter_signal_attrs_create(), and
> 
>         comp.count_u32_read = counter->ops->function_read;
>         comp.count_u32_write = counter->ops->function_write;
> 
> in counter_count_attrs_create() are currently safe under kCFI, since the
> final parameter type of the prototypes in 'struct counter_ops' does not
> match the final parameter type of the prototypes in 'struct
> counter_comp'. I would expect the indirect calls in counter_get_data()
> and counter_comp_u32_show() to fail currently.
> 
> I briefly looked at making the 'struct counter_comp' callbacks match the
> 'struct counter_ops' ones but the COUNTER_COMP macros in
> include/linux/counter.h made it seem like these callbacks might be used
> by implementations that might use different enumerated types as the
> final parameter. I can look a little closer to see if we can make
> everything match.
> 
> I am not sure how wrappers would work here, I can take a look into how
> feasible that is.

How about this? (I only did signal_read -- similar changes are needed
for function_read and function_write:

diff --git a/drivers/counter/counter-chrdev.c b/drivers/counter/counter-chrdev.c
index 80acdf62794a..cb391b2498a6 100644
--- a/drivers/counter/counter-chrdev.c
+++ b/drivers/counter/counter-chrdev.c
@@ -38,6 +38,7 @@ struct counter_comp_node {
 	a.device_u32_read == b.device_u32_read || \
 	a.count_u32_read == b.count_u32_read || \
 	a.signal_u32_read == b.signal_u32_read || \
+	a.signal_read == b.signal_read || \
 	a.device_u64_read == b.device_u64_read || \
 	a.count_u64_read == b.count_u64_read || \
 	a.signal_u64_read == b.signal_u64_read || \
@@ -54,6 +55,7 @@ struct counter_comp_node {
 	comp.device_u32_read || \
 	comp.count_u32_read || \
 	comp.signal_u32_read || \
+	comp.signal_read || \
 	comp.device_u64_read || \
 	comp.count_u64_read || \
 	comp.signal_u64_read || \
@@ -320,7 +322,7 @@ static int counter_add_watch(struct counter_device *const counter,
 			return -EINVAL;
 
 		comp_node.comp.type = COUNTER_COMP_SIGNAL_LEVEL;
-		comp_node.comp.signal_u32_read = counter->ops->signal_read;
+		comp_node.comp.signal_read = counter->ops->signal_read;
 		break;
 	case COUNTER_COMPONENT_COUNT:
 		if (watch.component.scope != COUNTER_SCOPE_COUNT)
@@ -530,6 +532,7 @@ static int counter_get_data(struct counter_device *const counter,
 	const size_t id = comp_node->component.id;
 	struct counter_signal *const signal = comp_node->parent;
 	struct counter_count *const count = comp_node->parent;
+	enum counter_signal_level level = 0;
 	u8 value_u8 = 0;
 	u32 value_u32 = 0;
 	const struct counter_comp *ext;
@@ -569,8 +572,8 @@ static int counter_get_data(struct counter_device *const counter,
 			ret = comp->device_u32_read(counter, &value_u32);
 			break;
 		case COUNTER_SCOPE_SIGNAL:
-			ret = comp->signal_u32_read(counter, signal,
-						    &value_u32);
+			ret = comp->signal_read(counter, signal, &level);
+			value_u32 = level;
 			break;
 		case COUNTER_SCOPE_COUNT:
 			ret = comp->count_u32_read(counter, count, &value_u32);
diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
index b9efe66f9f8d..07ce2543b70d 100644
--- a/drivers/counter/counter-sysfs.c
+++ b/drivers/counter/counter-sysfs.c
@@ -170,6 +170,7 @@ static ssize_t counter_comp_u32_show(struct device *dev,
 	const struct counter_attribute *const a = to_counter_attribute(attr);
 	struct counter_device *const counter = counter_from_dev(dev);
 	const struct counter_available *const avail = a->comp.priv;
+	enum counter_signal_level level = 0;
 	int err;
 	u32 data = 0;
 
@@ -178,7 +179,8 @@ static ssize_t counter_comp_u32_show(struct device *dev,
 		err = a->comp.device_u32_read(counter, &data);
 		break;
 	case COUNTER_SCOPE_SIGNAL:
-		err = a->comp.signal_u32_read(counter, a->parent, &data);
+		err = a->comp.signal_read(counter, a->parent, &level);
+		data = level;
 		break;
 	case COUNTER_SCOPE_COUNT:
 		if (a->comp.type == COUNTER_COMP_SYNAPSE_ACTION)
@@ -842,7 +844,7 @@ static int counter_signal_attrs_create(struct counter_device *const counter,
 
 	/* Create main Signal attribute */
 	comp = counter_signal_comp;
-	comp.signal_u32_read = counter->ops->signal_read;
+	comp.signal_read = counter->ops->signal_read;
 	err = counter_attr_create(dev, cattr_group, &comp, scope, signal);
 	if (err < 0)
 		return err;
diff --git a/include/linux/counter.h b/include/linux/counter.h
index c41fa602ed28..3f1516076f20 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -169,6 +169,9 @@ struct counter_comp {
 				      struct counter_count *count, u32 *val);
 		int (*signal_u32_read)(struct counter_device *counter,
 				       struct counter_signal *signal, u32 *val);
+		int (*signal_read)(struct counter_device *counter,
+				   struct counter_signal *signal,
+				   enum counter_signal_level *level);
 		int (*device_u64_read)(struct counter_device *counter,
 				       u64 *val);
 		int (*count_u64_read)(struct counter_device *counter,

-- 
Kees Cook
