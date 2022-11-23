Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C396C635D16
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 13:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236957AbiKWMkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 07:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237257AbiKWMkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 07:40:02 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728F166CB6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 04:39:57 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id fz10so11105652qtb.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 04:39:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HLgNVwihXVjPIO4s677P8tB/xH3LqpnC7zyfr5Rx+Ag=;
        b=MeSK6Dt2pGX6FtQkow9FBaOGswc5Se0/nnGQPhuKh2Sl9WDqAQGry0d6CN484zkAA5
         7S8eE6GpxUTAjdg65xVAmlUH7D2Atg5A5bnv1qoVO3fGsH2UBJcHIRulEl1LAhNk6EQh
         81bquedmV3xifY4S91FKY4hT/JGrLf4u0CCG2DkX/xgV+W6Wt3lhMbcJcU3JNp41Lr53
         5/6xRayioCgncKqxTs0xZno/rragftfNAcL9UvR7eS49rsf+jUh4Am6xQQWckgZhl55z
         rrxgvZ7A1bqV+rINVSLaLpKUut5TrTDMOiiWJ5DLUJLcMMTYU1Wp0u1CB0HvcGoKbqRF
         WMqg==
X-Gm-Message-State: ANoB5pmM50YYy0lrMsjXYnDcnJfo/fXiFn5abzrrBRD1s40yeyKjvlkI
        RE2baCR7s1Xk8ITM5fwI30uTp4G2NuN/M2jtuBI=
X-Google-Smtp-Source: AA0mqf5U0SLkqtbP91DPvMTLspsf8OVKPpBIqnZN+UdQz+mUC2+7U78bjeKafzQcdG+5P/HqMoKCPL0jBkmry0vhZXs=
X-Received: by 2002:a05:622a:410a:b0:3a5:5987:42c6 with SMTP id
 cc10-20020a05622a410a00b003a5598742c6mr26166402qtb.147.1669207196517; Wed, 23
 Nov 2022 04:39:56 -0800 (PST)
MIME-Version: 1.0
References: <20221123122523.1332370-1-gregkh@linuxfoundation.org> <20221123122523.1332370-5-gregkh@linuxfoundation.org>
In-Reply-To: <20221123122523.1332370-5-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 23 Nov 2022 13:39:45 +0100
Message-ID: <CAJZ5v0ijwXwctVF_+kLO2-MfP2+r_Mi1nQYEhbfmyypNYBkWvQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] driver core: device_get_devnode() should take a const *
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Won Chung <wonchung@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 1:25 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> device_get_devnode() should take a constant * to struct device as it
> does not modify it in any way, so modify the function definition to do
> this and move it out of device.h as it does not need to be exposed to
> the whole kernel tree.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Won Chung <wonchung@google.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/base/base.h    | 2 ++
>  drivers/base/core.c    | 2 +-
>  include/linux/device.h | 2 --
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index 7d4803c03d3e..a8a119c36bdc 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -158,6 +158,8 @@ extern void device_block_probing(void);
>  extern void device_unblock_probing(void);
>  extern void deferred_probe_extend_timeout(void);
>  extern void driver_deferred_probe_trigger(void);
> +const char *device_get_devnode(const struct device *dev, umode_t *mode,
> +                              kuid_t *uid, kgid_t *gid, const char **tmp);
>
>  /* /sys/devices directory */
>  extern struct kset *devices_kset;
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index a3e14143ec0c..72ec54a8a4e1 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3739,7 +3739,7 @@ static struct device *next_device(struct klist_iter *i)
>   * a name. This memory is returned in tmp and needs to be
>   * freed by the caller.
>   */
> -const char *device_get_devnode(struct device *dev,
> +const char *device_get_devnode(const struct device *dev,
>                                umode_t *mode, kuid_t *uid, kgid_t *gid,
>                                const char **tmp)
>  {
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 4ad1280713e6..e4498389e866 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -927,8 +927,6 @@ int device_rename(struct device *dev, const char *new_name);
>  int device_move(struct device *dev, struct device *new_parent,
>                 enum dpm_order dpm_order);
>  int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid);
> -const char *device_get_devnode(struct device *dev, umode_t *mode, kuid_t *uid,
> -                              kgid_t *gid, const char **tmp);
>  int device_is_dependent(struct device *dev, void *target);
>
>  static inline bool device_supports_offline(struct device *dev)
> --
> 2.38.1
>
