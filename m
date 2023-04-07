Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D576DAFDB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 17:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjDGPrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 11:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjDGPrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 11:47:21 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF5FAD21;
        Fri,  7 Apr 2023 08:47:20 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id r16so31300649oij.5;
        Fri, 07 Apr 2023 08:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680882439; x=1683474439;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=qB2M0BoOW9oaDa+VZga2Sa+0CVpbvNAMFJ6jBr8adc4=;
        b=W9vuUYRI92ldZRHzq2CMZKG5ZLeulX1EFpCXq2jVtrk7gb8aed3kzeM6l9/9xBKKoG
         3ZempnAh9kt6a5zjPFU0VqympiQCEQwprHwGPEL/jhzVSLiEd/USo49RfBUQvTs59sgJ
         BPq1d0xXBJcEBxH+FIfpQwJInS+ZmAUdU2+VQBIKjpfT44ZOJqNG0cAjEhyOdydmotsc
         VzmWEMD9ysXraekT6BPp5NFsTI/dbX8jM4/E7O+h37gPn2RJ7BT9nqa/hg6Vk1c8AagF
         5ma5njPBTlwOFShFIVFXCmgTPPqFG5pyE3/RK2wKHG2ekZKyPhVXFMy88621KGrZ+BZG
         O6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680882439; x=1683474439;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qB2M0BoOW9oaDa+VZga2Sa+0CVpbvNAMFJ6jBr8adc4=;
        b=FdXzAXMJyj+oUYsSi13UDB6pL6EXBHvVZWAe6cxyJip9OFGiSzOPx+tWBNf57RaQsl
         2hM3ROYfvg8Q7x3lJWGGephCTHfVVveb0KgD0r9LXiK+wc1e1lh7vwvoOS3MZbDjkAJG
         5Rha2TckE/jUkF5u9T26DugsKoEtCE1Zhwviz1orrASZk0cAWmSBiWC/uWhLrlgOTCJx
         z+UnhsJ1322aJE4EEQ4qCm6/30WWeE4PhM4uLG3CRarIuypYmiFwi/GVg2TiwlI91Tk3
         Rn1vm3II7c3zVQ3NIX7vufkjteYqjXmxBSYWpy7rnqMmtjsii42gl1fNsVagF4uHTRxj
         RGJg==
X-Gm-Message-State: AAQBX9dZlXXvDMh+GwSx1ABqTHzrGLNFFdpDGdd0IT2HuPUEXW+Z1Yfe
        hTLxg44KeRbIKessgAnhn6l1Jkp4Kvc=
X-Google-Smtp-Source: AKy350YRF1944XUhqK/zTgNLfplv2fuVJn1EoSRBMg7fIxIGXzJQxyVmCTTaZMkiFwyAd7YAHs4E7A==
X-Received: by 2002:aca:a84e:0:b0:38b:7eab:a482 with SMTP id r75-20020acaa84e000000b0038b7eaba482mr1145836oie.58.1680882439549;
        Fri, 07 Apr 2023 08:47:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e3-20020a05680809a300b00389509965e3sm1770396oig.58.2023.04.07.08.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 08:47:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 7 Apr 2023 08:47:17 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Oded Gabbay <ogabbay@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Marius Zachmann <mail@mariuszachmann.de>,
        Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Jean-Marie Verdun <verdun@hpe.com>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Rudolf Marek <r.marek@assembler.cz>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Jonas Malaco <jonas@protocubo.io>,
        Aleksandr Mezin <mezin.alexander@gmail.com>,
        Derek John Clark <derekjohn.clark@gmail.com>,
        =?iso-8859-1?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>,
        Iwona Winiarska <iwona.winiarska@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Walle <michael@walle.cc>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Agathe Porte <agathe.porte@nokia.com>,
        Eric Tremblay <etremblay@distech-controls.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        patches@opensource.cirrus.com, openbmc@lists.ozlabs.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 01/68] hwmon: constify pointers to hwmon_channel_info
Message-ID: <4127ea84-4217-4ae0-b88d-14e7ab5c6eff@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 10:29:56PM +0200, Krzysztof Kozlowski wrote:
> HWmon core receives an array of pointers to hwmon_channel_info and it
> does not modify it, thus it can be array of const pointers for safety.
> This allows drivers to make them also const.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Series applied.

Next time please let me know the base for your patch series.
It took me a while to figure out that it is based on linux-next.

Guenter
