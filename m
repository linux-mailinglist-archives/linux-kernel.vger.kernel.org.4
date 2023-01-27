Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3543667EC45
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 18:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbjA0RRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 12:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjA0RRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 12:17:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE8113B;
        Fri, 27 Jan 2023 09:17:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03069B807E4;
        Fri, 27 Jan 2023 17:17:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3359BC433EF;
        Fri, 27 Jan 2023 17:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674839829;
        bh=+cvE2fQZi3mu5hEuBLE5zQBc2bCQAd0K96ERekojksA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UYFcYCjnJbQnQqozXlF8GyUk6ZAi3jMFyt1zubuKko8GYWLR1UM3CPqUqKcBPsew0
         QLiOIB0xmBeeOUrH70UZvlBWrOw8zpMDN6D1sKOTAWgmOGDRY3xDajlpHgw6cw3KDy
         ghCkmT8CRYQTP3vOBpebXnkoNXVtxgsIDKtTIo1LB6UUqFO0jPP6lEZedUU3Y01CiE
         Tc+6QrkNfOv9RBJEZUArslNVIxCQTyhT6QVNrjp3sC0Z64KZP4Hy3+CV6MKSBPqXBQ
         e508U0odkcAXSQIZQ0U0Z72TK0SN4H3MpsWCF9Cw6nZIDzSbwGkPGD0SqPwL1DqmXR
         eRmco2xFSao5g==
Date:   Fri, 27 Jan 2023 17:17:01 +0000
From:   Lee Jones <lee@kernel.org>
To:     POOVENDHAN SELVARAJ <quic_poovendh@quicinc.com>
Cc:     Guru Das Srinagesh <quic_gurus@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, catalin.marinas@arm.com,
        will@kernel.org, shawnguo@kernel.org, arnd@arndb.de,
        marcel.ziswiler@toradex.com, dmitry.baryshkov@linaro.org,
        nfraprado@collabora.com, broonie@kernel.org, robimarko@gmail.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_devipriy@quicinc.com
Subject: Re: [PATCH 3/5] firmware: scm: Modify only the DLOAD bit in TCSR
 register for download mode
Message-ID: <Y9QHDXfpAETnCHi9@google.com>
References: <20230113160012.14893-1-quic_poovendh@quicinc.com>
 <20230113160012.14893-4-quic_poovendh@quicinc.com>
 <20230114011606.GA24659@quicinc.com>
 <659c81b0-b75e-9a6f-bd26-878bb9868397@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <659c81b0-b75e-9a6f-bd26-878bb9868397@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jan 2023, POOVENDHAN SELVARAJ wrote:

> 
> On 1/14/2023 6:46 AM, Guru Das Srinagesh wrote:
> > On Jan 13 2023 21:30, Poovendhan Selvaraj wrote:
> > > Add support to read-modify-write TCSR register to modify only DLOAD bit.
> > Could you please add more details on what problem this patch is fixing, and why
> > this patch is needed?
> > 
> > CrashDump collection is based on the DLOAD bit of TCSR register. To retain other bits, we read the register and modify only the DLOAD bit as the other bits have their own significance.
> > 
> > Thank you.
> > 
> > Guru Das.
> > 
> > Regards,
> > Poovendhan S

Could you please fix your email client.

I have no idea which text is yours, in any of your mails.

-- 
Lee Jones [李琼斯]
