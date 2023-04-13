Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C94B6E05DE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 06:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjDMESB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 00:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjDMERX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 00:17:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3E6172C;
        Wed, 12 Apr 2023 21:15:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDB5963439;
        Thu, 13 Apr 2023 04:15:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1C6C4339B;
        Thu, 13 Apr 2023 04:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681359341;
        bh=BmvSeStlY/3OFiQagQGoFed7dwR+A0UXBFPAOqd2MKE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=JKK8FIPWTcONpK0kcAc1QD4p15wfvOgd0AKViIdWnl58ICoojmTPqU7gR0hgmw13h
         byVx5WhdchdVQRvg4IhdZsQ2CAzBWKWKNUVw3x8Bokl+3qDhimaUntwxOoH5XVAaf7
         jdzd2Sw348lkVTnzNxhyhJDgG2KY5h4B9owSJZgjsttVKdsjYqJrVWx1sDQYmp0d/o
         lhw0YzSPX7mHtRHhY5A/oTwwDqjHdKHjGUQrWnFLtWWQekNKNbq/MqHr+xTM6Snd4e
         YMm8ovBlGHMjoy3imd7EAZ3DqiBGb8YXS0e8htDa9mfmk/nvoo5GOOVtvuWFHVdyqy
         +lefBsX3rS9UQ==
Message-ID: <8c774af24fa89d44924998064a996a2c.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1671601032-18397-2-git-send-email-quic_jprakash@quicinc.com>
References: <1671601032-18397-1-git-send-email-quic_jprakash@quicinc.com> <1671601032-18397-2-git-send-email-quic_jprakash@quicinc.com>
Subject: Re: [PATCH] spmi: Add a check for remove callback when removing a SPMI driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        Jishnu Prakash <quic_jprakash@quicinc.com>
To:     Jishnu Prakash <quic_jprakash@quicinc.com>, agross@kernel.org,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        quic_collinsd@quicinc.com, quic_kamalw@quicinc.com,
        quic_subbaram@quicinc.com, robh+dt@kernel.org
Date:   Wed, 12 Apr 2023 21:15:39 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jishnu Prakash (2022-12-20 21:37:12)
> When removing a SPMI driver, there can be a crash due to NULL pointer
> dereference if it does not have a remove callback defined. This is
> one such call trace observed when removing the QCOM SPMI PMIC driver:
>=20
>  dump_backtrace.cfi_jt+0x0/0x8
>  dump_stack_lvl+0xd8/0x16c
>  panic+0x188/0x498
>  __cfi_slowpath+0x0/0x214
>  __cfi_slowpath+0x1dc/0x214
>  spmi_drv_remove+0x16c/0x1e0
>  device_release_driver_internal+0x468/0x79c
>  driver_detach+0x11c/0x1a0
>  bus_remove_driver+0xc4/0x124
>  driver_unregister+0x58/0x84
>  cleanup_module+0x1c/0xc24 [qcom_spmi_pmic]
>  __do_sys_delete_module+0x3ec/0x53c
>  __arm64_sys_delete_module+0x18/0x28
>  el0_svc_common+0xdc/0x294
>  el0_svc+0x38/0x9c
>  el0_sync_handler+0x8c/0xf0
>  el0_sync+0x1b4/0x1c0
>=20
> If a driver has all its resources allocated through devm_() APIs and
> does not need any other explicit cleanup, it would not require a
> remove callback to be defined. Hence, add a check for remove callback
> presence before calling it when removing a SPMI driver.
>=20
> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
> ---

Applied to spmi-next
