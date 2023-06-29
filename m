Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCE474265D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 14:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjF2M1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 08:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbjF2M05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 08:26:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F197A10FD;
        Thu, 29 Jun 2023 05:26:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F34E61540;
        Thu, 29 Jun 2023 12:26:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B77C433C8;
        Thu, 29 Jun 2023 12:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688041576;
        bh=LS52vXkYfLsp8nOl2NekhIKUNII1QAdyPvLr7arBdP0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mRxW0wUiy6WtBT08Rz/9diVeNseJ0fg3hzY3GLMmm0VovfhydkgknKPbpmuhCnQyy
         UuRR1DXAGwNS0pxytNA/D/fC/yS6gqlOzLv2F8LHnZ6IPqCE2fsNIpPAex/4/aUKb9
         oqvuUaPFHfmQlWAlRY0Bhq1c/CYNPnXFj0F3lY3TAR48JFrmDRpO3bKj5LlO9wSe9S
         uoU++8QfLbXsg3gLPjXVeDE0WgsPkxv46bo2PTBG3AVYorqOT30hW7oT8Ivpf4aQUb
         qsAcLobA6uY7SFlX+aMl629GlhVHlPai7tJ62jBnNGiQsJOCF5xvBMFrVpX2+mupKZ
         w4Ki2FQ/ZB7jQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1qEqj5-0005zd-75; Thu, 29 Jun 2023 14:26:19 +0200
Date:   Thu, 29 Jun 2023 14:26:19 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] firmware: Add support for Qualcomm UEFI Secure
 Application
Message-ID: <ZJ14a5SNS8L3XyFb@hovoldconsulting.com>
References: <20230305022119.1331495-1-luzmaximilian@gmail.com>
 <20230305022119.1331495-5-luzmaximilian@gmail.com>
 <2eb4abde-579f-94ef-b6c3-81ef197329d0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2eb4abde-579f-94ef-b6c3-81ef197329d0@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 05:51:35PM +0200, Dmitry Baryshkov wrote:
> On 05/03/2023 04:21, Maximilian Luz wrote:

> > +static struct qcuefi_client *qcuefi_acquire(void)
> 
> Doesn't this need  the __locks annotation?

No, the mutex implementation does not use sparse annotation so adding
__acquires() here will instead introduce new warnings.

> > +{
> > +	mutex_lock(&__qcuefi_lock);
> > +	return __qcuefi;
> > +}

Johan
