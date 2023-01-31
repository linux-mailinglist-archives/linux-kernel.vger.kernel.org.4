Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7B6682B46
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 12:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjAaLQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 06:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbjAaLQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 06:16:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AA24B199
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 03:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675163711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r5WDosCN8ptqhgrL1cgVrQgfmxbqRf8M/DBi7ayRhQA=;
        b=hdu8fi4eHzLWPnWrvZOAPzjJfls+owyup7E5vUYITIeyUL3WXT8Z64fTRYQj3JIG+o+ln8
        C8xcY/wvvDwhVGOJYuj+MbctudiNpto+KHA9+SosAWUo/rVhjTIUERZ4/BvREuJB8Mh2+c
        loHNlATDohdEUlrZoh2765nwWIMIego=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-562-goArzcsgPEySSm9lHODGfA-1; Tue, 31 Jan 2023 06:15:08 -0500
X-MC-Unique: goArzcsgPEySSm9lHODGfA-1
Received: by mail-qk1-f199.google.com with SMTP id a3-20020a05620a438300b007069b068069so8839318qkp.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 03:15:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r5WDosCN8ptqhgrL1cgVrQgfmxbqRf8M/DBi7ayRhQA=;
        b=oXUxmFH6WJBLMic09+pd4li36diBIOu6oM4ozsGdeha72rv4atvLDBEzcolb4XPvEe
         qxOrAQcIfcHLNPncRjCXJi083U/qHSyrJNXZ9hV6O+YLlT6nXKnoUnGbBShlf90bNF32
         XuHY54WI4tZtuOy9H2Tu4rWwdLDOzTirY24VykxkXbmdCaXteeNdf/P4hZ8tymVoLxpi
         E9NO0PN0K3q76KLpLDRwcGp0dznXH8GNZFJfomVSfhtC6VX+E/7xQdt6xSBpeh0zpW4H
         VcNWDUrVVUlcHnNCGK/bBON3X1GU62FZIQHKGdnaTCj4O+Qo385w1ywM+aaUXckPh95U
         J+zw==
X-Gm-Message-State: AO0yUKVeD9JchKAYVYUDJ2a2OsZqn3lZX3uI/UlddiYZlrJjEjc0M1Dg
        Wm/lDrBmU31LvN4UX5rBh+WzH8uXfKo3PYvLIGVj7Mt/HDYa8giB4A/NGOPle7ZrWMiYLhoAkVE
        SMjV7L1WZD9rHlhEtNSFx44lg
X-Received: by 2002:a05:6214:b85:b0:537:6dfa:efaf with SMTP id fe5-20020a0562140b8500b005376dfaefafmr33023148qvb.13.1675163708315;
        Tue, 31 Jan 2023 03:15:08 -0800 (PST)
X-Google-Smtp-Source: AK7set9PvPYF6HAkQ+AlinxEAf03bWrkLFOaUAgoOy2qSI7bVMAHunwsC9vjqR1Y96nmCMq2TF5yVg==
X-Received: by 2002:a05:6214:b85:b0:537:6dfa:efaf with SMTP id fe5-20020a0562140b8500b005376dfaefafmr33023117qvb.13.1675163708088;
        Tue, 31 Jan 2023 03:15:08 -0800 (PST)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id bs32-20020a05620a472000b0071d7ade87afsm4839339qkb.67.2023.01.31.03.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 03:15:07 -0800 (PST)
Date:   Tue, 31 Jan 2023 06:15:05 -0500
From:   Brian Masney <bmasney@redhat.com>
To:     Steev Klimaszewski <steev@kali.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Sven Peter <sven@svenpeter.dev>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Mark Pearson <markpearson@lenovo.com>
Subject: Re: [PATCH v2 3/4] arm64: dts: qcom: sc8280xp: Define uart2
Message-ID: <Y9j4ORb4r8+QXx4J@x1>
References: <20230131043816.4525-1-steev@kali.org>
 <20230131043816.4525-4-steev@kali.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131043816.4525-4-steev@kali.org>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 10:38:15PM -0600, Steev Klimaszewski wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Steev Klimaszewski <steev@kali.org>

Reviewed-by: Brian Masney <bmasney@redhat.com>

