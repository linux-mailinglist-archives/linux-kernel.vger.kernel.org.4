Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A9061A02E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 19:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbiKDSmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 14:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbiKDSlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 14:41:53 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5272FFF6
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 11:41:50 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id h14so5251453pjv.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 11:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0/e3XNedcUafbur2krWu5QjN/qTE3byumYrWwxXDmZc=;
        b=kGSjUhZTyjnX8YG/47uimIoE2UEf9s/oVTICYJrEQO5GSp1K8+xNIGyKeF1KhMmemV
         k7ZbxfVkOQLiTfy90ca5LLathM338Bh+RvXpY0YYBtJGZNTf5qg8koUOtFY1ugoW6J8h
         Z89WoUjNYf4aucrM/3Toa4/13NvqSniAzQs7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/e3XNedcUafbur2krWu5QjN/qTE3byumYrWwxXDmZc=;
        b=uQeYBIv3VkGgCATcnEm87Yn1gdjGhVFpw0y7ykPcXb+XRJZKRdiVLgjbLkSRWtAAIt
         WikF6xdSiSV8NUxrtDQr2lJpTH5TDfoEoTpJbAPanuO8B4wcCcQUWajP/qDyLPTajLGG
         HXwy3q2JT0E5pldst4jOTvqS/37XXr+6bvnK2JX+WxsPSEQftjir542T128Fr0AkUOX0
         iV0jSZaVhJVoPhpkzI0AL6JDudt3JzaM5yxSNcHxgbCAA4ylAh0XQbs5yy2huls8e3vF
         o870Pb4AUt+NdiKeLd/c1ugqLp8ONsDrjzbO8C8c9iS52vhBTXma8q4yrdXgZKcpw71A
         0Ztw==
X-Gm-Message-State: ACrzQf2cdaYt91fZMmAZmFGSGHob4BNUZVBpIBPAjJKhlEq3spqudQY3
        hfLeheSXkVh6oseBqQ5klpL7kg==
X-Google-Smtp-Source: AMsMyM5/IPN5VMplBtILamsruzNtJlYqyGvnWzu4y+2P1igwwYuJl16YKo0t3xoP5o5K5UwU0dTZrA==
X-Received: by 2002:a17:903:200b:b0:186:892f:9f0b with SMTP id s11-20020a170903200b00b00186892f9f0bmr36374630pla.56.1667587310437;
        Fri, 04 Nov 2022 11:41:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p5-20020a170902780500b00186c37270f6sm99028pll.24.2022.11.04.11.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 11:41:50 -0700 (PDT)
Date:   Fri, 4 Nov 2022 11:41:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net, gwendal@chromium.org,
        apronin@chromium.org, Pavel Machek <pavel@ucw.cz>,
        Matthew Garrett <mgarrett@aurora.tech>,
        linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        zohar@linux.ibm.com, dlunev@google.com,
        Eric Biggers <ebiggers@kernel.org>,
        Ben Boeckel <me@benboeckel.net>, jarkko@kernel.org,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 08/11] PM: hibernate: Use TPM-backed keys to encrypt
 image
Message-ID: <202211041139.15A90C4EED@keescook>
References: <20221103180120.752659-1-evgreen@chromium.org>
 <20221103105558.v4.8.Ibd067e73916b9fae268a5824c2dd037416426af8@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103105558.v4.8.Ibd067e73916b9fae268a5824c2dd037416426af8@changeid>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 11:01:16AM -0700, Evan Green wrote:
> When using encrypted hibernate images, have the TPM create a key for us
> and seal it. By handing back a sealed blob instead of the raw key, we
> prevent usermode from being able to decrypt and tamper with the
> hibernate image on a different machine.
> 
> We'll also go through the motions of having PCR23 set to a known value at
> the time of key creation and unsealing. Currently there's nothing that
> enforces the contents of PCR23 as a condition to unseal the key blob,
> that will come in a later change.
> 
> Sourced-from: Matthew Garrett <mjg59@google.com>

I'd say Suggested-by. "Source-from:" is not a tag that has ever been
used before. :)

Otherwise, looks good.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
