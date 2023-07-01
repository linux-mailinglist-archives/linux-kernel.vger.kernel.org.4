Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDC5744582
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 02:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjGAAUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 20:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjGAAUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 20:20:42 -0400
Received: from vps0.lunn.ch (unknown [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124083A9B;
        Fri, 30 Jun 2023 17:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=RSoC/5hYUUQ3sGJr52lBB+aV7IzoV8b72rkry2pxCQg=; b=yAyplwTga+cJQhNVxS4WCa0avC
        XATcUdMc7wgQTO46g7k9dcH2lTxfJGRCofunObU6mN+84w113eNMP2VoKVQEFW1R1wTRQT0i64hLW
        KT9C9WzHFOqZAlNELVDobW+4G2P/rybEr2j3erhGyjDcrRq59amX2UprnR8BcrFLmzDQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qFOKp-000LM8-66; Sat, 01 Jul 2023 02:19:31 +0200
Date:   Sat, 1 Jul 2023 02:19:31 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Evan Quan <evan.quan@amd.com>
Cc:     rafael@kernel.org, lenb@kernel.org, Alexander.Deucher@amd.com,
        Christian.Koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, johannes@sipsolutions.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        Mario.Limonciello@amd.com, mdaenzer@redhat.com,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        hdegoede@redhat.com, jingyuwang_vip@163.com, Lijo.Lazar@amd.com,
        jim.cromie@gmail.com, bellosilicio@gmail.com,
        andrealmeid@igalia.com, trix@redhat.com, jsg@jsg.id.au,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH V5 1/9] drivers core: Add support for Wifi band RF
 mitigations
Message-ID: <7e7db6eb-4f46-407a-8d1f-16688554ad80@lunn.ch>
References: <20230630103240.1557100-1-evan.quan@amd.com>
 <20230630103240.1557100-2-evan.quan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630103240.1557100-2-evan.quan@amd.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Drivers/subsystems contributing frequencies:
> 
> 1) During probe, check `wbrf_supported_producer` to see if WBRF supported
>    for the device.

What is the purpose of this stage? Why would it not be supported for
this device?

> +#ifdef CONFIG_WBRF
> +bool wbrf_supported_producer(struct device *dev);
> +int wbrf_add_exclusion(struct device *adev,
> +		       struct wbrf_ranges_in *in);
> +int wbrf_remove_exclusion(struct device *dev,
> +			  struct wbrf_ranges_in *in);
> +int wbrf_retrieve_exclusions(struct device *dev,
> +			     struct wbrf_ranges_out *out);
> +bool wbrf_supported_consumer(struct device *dev);
> +
> +int wbrf_register_notifier(struct notifier_block *nb);
> +int wbrf_unregister_notifier(struct notifier_block *nb);
> +#else
> +static inline bool wbrf_supported_producer(struct device *dev) { return false; }
> +static inline int wbrf_add_exclusion(struct device *adev,
> +				     struct wbrf_ranges_in *in) { return -ENODEV; }
> +static inline int wbrf_remove_exclusion(struct device *dev,
> +					struct wbrf_ranges_in *in) { return -ENODEV; }

The normal aim of stubs is that so long as it is not expected to be
fatal if the functionality is missing, the caller should not care if
it is missing. So i would expect these to return 0, indicating
everything worked as expected.

> +static inline int wbrf_retrieve_exclusions(struct device *dev,
> +					   struct wbrf_ranges_out *out) { return -ENODEV; }

This is more complex. Ideally you want to return an empty set, so
there is nothing to do. So i think the stub probably wants to do a
memset and then return 0.

> +static inline bool wbrf_supported_consumer(struct device *dev) { return false; }
> +static inline int wbrf_register_notifier(struct notifier_block *nb) { return -ENODEV; }
> +static inline int wbrf_unregister_notifier(struct notifier_block *nb) { return -ENODEV; }

And these can just return 0.

    Andrew
