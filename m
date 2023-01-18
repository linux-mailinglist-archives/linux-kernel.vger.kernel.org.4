Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443A76717C1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 10:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjARJ3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 04:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjARJXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 04:23:17 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C231878AB4;
        Wed, 18 Jan 2023 00:47:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1674031655; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=TcCGyEgo6Qao6KmNRk3zvg9d3vQZkcfrVTcQMmDQT9KZeodDKuivyb3zLImp0PHf/1
    Sy1f2cXtzYlFOgrKYazcZHfER2xpgGjSDoRDiOpgFpyI6+MaeVChxp8idbgYkHGW3MyI
    VYKbgf6JfqQPzhQEsgl8OC/R41ELqQsgBPhoPB1DnEX1WX4txNuJ2m9eqAgGw8UCXoAa
    /C1wc9YkSzK+WT12TmmRFtM+AwgcVAJUhGb71dKohmfZ7h7tcWmugh2YMzsSIPJcprAr
    2YzyiKUgHbZpr8Nor3skYAwvscZrSLMRhVcrSQ4zjwTZd3Ov9YQRLdMYqOUiyKSkjkos
    Yzcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1674031655;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=6OM+98Zg5AKMW00qUsRvqkrqoox/NO870n6+38ilnf0=;
    b=fD5AnTLjhL7UEohPTE3fVhyT4aKpFBO2KC/IzAzFNT6kKvdSXyedtyYliA9w8yncPw
    Jv90P8Kmf16Q7WQKioNj/zLOwKELhYahkRZAD387tbgjsrkohUqtBXArVOsfB3Y0ZmcI
    iA38swBCK3W47/O6rNkLskkLj/oRZyfAoiwvcY0D3xPBIMSua60q2ROO64fsbeXxetss
    CdMDR8EnrReSM7URXNKL9au1mjPB60ZFfiI8aVQsJUiuMLOec81Zq14u/69WZBye3yH9
    Zlf5myGvbmSUc8UjHJ59M4mSHccxjR2k8836Kj1GMjC+VgJQE7i/11L2Go7lmR7x5CuX
    4nQQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1674031655;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=6OM+98Zg5AKMW00qUsRvqkrqoox/NO870n6+38ilnf0=;
    b=J+YhEtQrTAAhk49PyKCqEkF8adhBEFjCyEwcQ0AfgzpmRbfIL6Xeg91q7mB2NNFdgj
    1bCM/IbqLA0Zt3pXfokuwYBQ3FUcgC65/JYsvz0OENcTA3NEgVJ94RN+1vIp7Mwh4FR/
    6V5mZSu49mOLuvkGIWFHX2VQLsyvRmX0Swow71IhCfWsInjOVuRVrirJaI1iFotgFrYT
    6Cazf6ebUlCYDNkEUwdrzoynS3HUuZGfZqIJFjFZ8TDKHFl0VDm3BPjTeB82FqES5NoV
    LPuURj14vrIE64Mfwsq+eU1K3KYg1yrehUQkosqeEHrw2ym2GeNPotFrqA+TeWXBzjCR
    F0RQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJAhdlWx/bI"
Received: from gerhold.net
    by smtp.strato.de (RZmta 48.6.2 DYNA|AUTH)
    with ESMTPSA id yacdeez0I8lYLd9
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 18 Jan 2023 09:47:34 +0100 (CET)
Date:   Wed, 18 Jan 2023 09:47:28 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benl@squareup.com,
        shawn.guo@linaro.org, fabien.parent@linaro.org, leo.yan@linaro.org,
        dmitry.baryshkov@linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 1/8] dt-bindings: arm: qcom: Document MSM8939 SoC
 binding
Message-ID: <Y8eyIO8BqKzvulbB@gerhold.net>
References: <20230117024846.1367794-1-bryan.odonoghue@linaro.org>
 <20230117024846.1367794-2-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117024846.1367794-2-bryan.odonoghue@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 02:48:39AM +0000, Bryan O'Donoghue wrote:
> Document the MSM8939 and supported boards in upstream Sony "Tulip" M4 Aqua
> and Square APQ8039 T2.
> 
> MSM8939 is one of the older SoCs so we need to expand the list of
> qcom,board-ids to allow for the bootloader DTS board-id matching
> dependency.
> 

The original LK bootloaders cannot boot your msm8939.dtsi correctly,
because a spin-table implementation is required to get the other CPU
cores up. This means that a modified bootloader is always needed from
the upstream point of view, since I doubt anyone wants to use these
devices with a single core only. lk2nd (as the primary spin-table
implementation right now) has never required qcom,board-ids and any
custom LK would be easy to patch to ignore these.

Do you already have a bootloader with spin-table support deployed in the
field that can be no longer easily modified to ignore the qcom,board-id?

If not, and you're planning to keep using the downstream patches to
bring the CPU cores up without spin-table/PSCI then you might as well
add the qcom,board-id as downstream patch as well.

If we don't support the original bootloaders in a usable way upstream
then we should not add MSM8939 to the allow list of broken bootloaders
either, in my opinion.

Thanks,
Stephan
