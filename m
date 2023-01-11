Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA17665980
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 11:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbjAKKyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 05:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238912AbjAKKyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:54:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A747026CA
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 02:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673434395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wdMPDFYa0f6XjF6DYomIKbpIUsGfFZ+jIpGTyJ2mckk=;
        b=U95wKkI9yYMxpwEMFrdgsFaH0IovAcBK7ha9V2Bs0zKOy4v503Vuz6ZpjAMGAD0iB0ETeX
        ONyPuq2DZxECdkyEyTHASnAOrc9T1ukndSBMaZ4D23ZoDhevfC97yN0+yeV3o00qKtfuEu
        +azqoF5Qr03dkvOb+2RF0uWMQqbgNy8=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-237-7EQ0D4kMOuukkqpBJvT9bw-1; Wed, 11 Jan 2023 05:53:14 -0500
X-MC-Unique: 7EQ0D4kMOuukkqpBJvT9bw-1
Received: by mail-il1-f199.google.com with SMTP id r6-20020a92cd86000000b00304b2d1c2d7so10608887ilb.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 02:53:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wdMPDFYa0f6XjF6DYomIKbpIUsGfFZ+jIpGTyJ2mckk=;
        b=n5mG3BR3lYN5kDME7U+P8EPWlKY01/VGMg7FvIrsF77mzbD8lG0uY8FzFToWLVFXwW
         jrwh6rUpEgL+GbRw/ApefGRAMwlhVKsT3lkmNW8vjrMzB56i0bUGebqXcT58gNFDkkaX
         yH+gMoc603dWb/ye18sqeWA0nSS6A8IIycrAC6eUsKlRXbgxfUfnHuHabPL5Mhj/GWWM
         FxdaqAzqjEG3OLSxeh2kvcDQHT4eS1UDqYESDU6jQ4RcBMbirIAg9wYc9iVUwiBjWTQm
         sbOK9EoobaLuAK6MkZV7Cu2vIUtECV6roOb3Gzq86GOXuxt7jQWZ6zThswM5EijHEw0H
         Lzew==
X-Gm-Message-State: AFqh2krDZWQsX5v2indI0A38wytEexerYwhHEmXt+Tnnc/5NkVRP70Mt
        dJeevgUIRW6/tt4+govrvHYQvvm50b09893WIlvO+eHxJJiObSGeJEzauYaZL3NrIc6a8vQCVKO
        PsdqvPkKqG+4XM1cpbQXkJoyc
X-Received: by 2002:a5e:dd08:0:b0:6e2:cfcf:f2cf with SMTP id t8-20020a5edd08000000b006e2cfcff2cfmr48656532iop.16.1673434393994;
        Wed, 11 Jan 2023 02:53:13 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsEaFXbzyydyfCrHx57ew4eSAOphJ55zIPsm7jjLm0TZ2PS5N/LyFk5tDV6fmGuWU1msOsLdQ==
X-Received: by 2002:a5e:dd08:0:b0:6e2:cfcf:f2cf with SMTP id t8-20020a5edd08000000b006e2cfcff2cfmr48656526iop.16.1673434393809;
        Wed, 11 Jan 2023 02:53:13 -0800 (PST)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id b12-20020a056e02184c00b002faf6559e90sm4336528ilv.51.2023.01.11.02.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 02:53:13 -0800 (PST)
Date:   Wed, 11 Jan 2023 05:53:11 -0500
From:   Brian Masney <bmasney@redhat.com>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Eric Chanudet <echanude@redhat.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sa8450p-pmics: rename pmic labels
Message-ID: <Y76VF1a3dM1sAfAG@x1>
References: <20230111082331.20641-1-johan+linaro@kernel.org>
 <20230111082331.20641-3-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111082331.20641-3-johan+linaro@kernel.org>
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

On Wed, Jan 11, 2023 at 09:23:31AM +0100, Johan Hovold wrote:
> The SA8540P PMICs are named PMM8540. Rename the devicetree source labels
> to reflect this.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Brian Masney <bmasney@redhat.com>

