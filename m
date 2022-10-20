Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C2C6065E2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiJTQd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiJTQdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:33:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33BE1C4EDA
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666283633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+PN9Zmo6gmcoTAvY3Ztc9ZICuuK1P6MwzJ+pG+ZS7pk=;
        b=O2dmEAOBdK18ll39MZY5h0xJlh6SMaZuZ06aoKlFbakAvjIPvxx1/QUYNR5558O0Phlukw
        WCQVBfsmyZUX7nV6JhfXWzF1E7HJCc5O8f/x14UnF4THyEtk5v61ECl5r7BKWw2ToJGpgm
        zlmLjWjeuxdT0kxPvTjA2V2xAyD6Hz0=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-42-UusmGaUaOJe9E28upQqWUg-1; Thu, 20 Oct 2022 12:33:44 -0400
X-MC-Unique: UusmGaUaOJe9E28upQqWUg-1
Received: by mail-il1-f198.google.com with SMTP id y13-20020a056e021bed00b002faba3c4afbso286847ilv.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:33:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+PN9Zmo6gmcoTAvY3Ztc9ZICuuK1P6MwzJ+pG+ZS7pk=;
        b=Sjwih47hJilLeo7FYZwknrMuTtjEA1jfXPO6fMe5hILfycWnk1Nx7Btaj7UqCa5XgN
         Y5XPFtZOUal3TQdZtc7QN747NbjpStfsIxgVJ6m0VP6J+D5Nct6w8G002Viptn3KM2Za
         V/LG1m6LZN2uTKpNnYng8PFhW5AAKaFTHq/TUO6SzM8ceCZxJzyK1rGtuWKlPoPakdmX
         RZITmBweKb9vvMiFa2nuYbuWxaWS69VQ94/GiROwqtybg6cvpquVLaX4/lqk2W1jMfS0
         26iA23nWzvHI6lbMmGwNOjhlycHXZtig4nSGeri7v3/pok320pSjTVmZuKyY8ghpgrve
         TTFg==
X-Gm-Message-State: ACrzQf2LPE9oUiX3exyZWtuLuHL5rPQMFt1KA/+LeGltmfBG1KD+ZcKC
        GvWuONh+IsPgdtRmRSavlj1aH6cjzJ+2AEhaGy1aMIlo7Kj8dN4rvlwM96sijrKqMebKN1vRpoe
        jnVc4zm+wWUvAbjp92I8ZlEY/
X-Received: by 2002:a05:6e02:1546:b0:2fd:1a72:8825 with SMTP id j6-20020a056e02154600b002fd1a728825mr10907262ilu.83.1666283623522;
        Thu, 20 Oct 2022 09:33:43 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7XHdv+alEzff5ONYljf0u9Vv1MKFPW6k4p9y5USRUJuL/pvytZkuf5ZoBiDEPgV8q09Ix6lw==
X-Received: by 2002:a05:6e02:1546:b0:2fd:1a72:8825 with SMTP id j6-20020a056e02154600b002fd1a728825mr10907245ilu.83.1666283623274;
        Thu, 20 Oct 2022 09:33:43 -0700 (PDT)
Received: from x1 (c-98-239-145-235.hsd1.wv.comcast.net. [98.239.145.235])
        by smtp.gmail.com with ESMTPSA id c4-20020a92cf44000000b002ff36cb0a62sm883868ilr.27.2022.10.20.09.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 09:33:42 -0700 (PDT)
Date:   Thu, 20 Oct 2022 12:33:40 -0400
From:   Brian Masney <bmasney@redhat.com>
To:     Parikshit Pareek <quic_ppareek@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v6 1/2] dt-bindings: arm: qcom: Document additional
 sa8540p device
Message-ID: <Y1F4ZMAhHWRd9c3m@x1>
References: <20221020073036.16656-1-quic_ppareek@quicinc.com>
 <20221020073036.16656-2-quic_ppareek@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020073036.16656-2-quic_ppareek@quicinc.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 01:00:35PM +0530, Parikshit Pareek wrote:
> Add the qdrive3 ride device to the valid device compatibles found on the
> sa8540p platform.
> 
> Signed-off-by: Parikshit Pareek <quic_ppareek@quicinc.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>

