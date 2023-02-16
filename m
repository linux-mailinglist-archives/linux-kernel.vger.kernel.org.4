Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD86698D49
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 07:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjBPGoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 01:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBPGn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 01:43:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664AA273A;
        Wed, 15 Feb 2023 22:43:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00D3161DAC;
        Thu, 16 Feb 2023 06:43:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D051EC433D2;
        Thu, 16 Feb 2023 06:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676529836;
        bh=pCLGTlYBFyupZgL2IE9Tt2F0/qgXvoVlOCMrCJO6ur8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tnvWcYvdLAZPtMeghkOysW0Pk1JS8aUxANHeYPjwY2R/ljRuG280abpVEm8kHaTgM
         ar3+Glb4vEBrQbRMOGg6isgCPu/BlBE/JaaD6JzxvS3VzDtBkk3Lr+0sSCYa4+6C12
         5sNDQGF8l3hsOUs6+XyxCHZOTcFiocWwoqp7UdsM=
Date:   Thu, 16 Feb 2023 07:43:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v10 08/26] gunyah: rsc_mgr: Add resource manager RPC core
Message-ID: <Y+3QqdQVH5BTbnaP@kroah.com>
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214212327.3310128-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214212327.3310128-1-quic_eberman@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 01:23:25PM -0800, Elliot Berman wrote:
> +struct gh_rm {
> +	struct device *dev;

What device does this point to?

> +	struct gunyah_resource tx_ghrsc, rx_ghrsc;
> +	struct gh_msgq msgq;
> +	struct mbox_client msgq_client;
> +	struct gh_rm_connection *active_rx_connection;
> +	int last_tx_ret;
> +
> +	struct idr call_idr;
> +	struct mutex call_idr_lock;
> +
> +	struct kmem_cache *cache;
> +	struct mutex send_lock;
> +	struct blocking_notifier_head nh;
> +};

This obviously is the "device" that your system works on, so what are
the lifetime rules of it?  Why isn't is just a real 'struct device' in
the system instead of a random memory blob with a pointer to a device?

What controls the lifetime of this structure and where is the reference
counting logic for it?

And why no documentation for this core structure?

thanks,

greg k-h
