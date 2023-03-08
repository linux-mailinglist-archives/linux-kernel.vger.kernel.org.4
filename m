Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82606B07F2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjCHNHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjCHNHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:07:04 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70419498B2;
        Wed,  8 Mar 2023 05:05:15 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id k10so41515228edk.13;
        Wed, 08 Mar 2023 05:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678280639;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zs0UM8kM2VnC2EAMlxdhs+9Wg86DimtKYhjwLouXb0w=;
        b=phI9E6E+6NGntYmcjDEaftMqtjJ3KQXg966Z6kvp9OWhYYOdJadiRO3U7J8+NH/ix9
         VV+VugQFAc2Vl04g84B/J4Bb44ibJqWmiu1rBp31KbUvWUw60a9q7lrITgVucTksu8oc
         7sr9C+DUxF5tKUudh2xq75LYqziavUsjqLmlWz62k+nN528NzxXIps/sNGKPppTYdZMl
         EzzxXWRNn7YBjCbH8l2vkCqHMsCUVgJAfA9XnBkxBm8Zgee9uBa9F+4tKISmw2gIT5po
         6SDN9B2jRrjWDrimAFCgGGlUikQCHXI2pVQl7+D5waqvvPAqZIid0++6S78iN3iPlT66
         HzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678280639;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zs0UM8kM2VnC2EAMlxdhs+9Wg86DimtKYhjwLouXb0w=;
        b=3j6fRAYCDEzqCNv49WGWFjE7GkUpLeNvSnKOCbQ35icHl1+iIqggs7jjRcKGnnjVlF
         f6Uzwp2yrgm5boAZHum6SgxQQx9LazOyszDpQsNKxmSljDFB1G2tyu2Xslk5PdzyNwb9
         wpHaHe4Vr0BhGyNIHUh+hEiB7AuEUF9aAG3evEGRJ2fb1CDLgDh8mEr7yfBYBQpgwXGQ
         3Yol8bRkZXaLll2SmGQ48bkvf/HdznUCE9tndSyyZbYjmiZLhdmA8o/NWOlvYS0CWB3m
         aH5XxcVqsjdMsesHpbZ8QKO/1jnfY2pDJlT0DqwftNV7LXpiPmZ9+K+kjkWjx7aclbMI
         SOtw==
X-Gm-Message-State: AO0yUKUP9n6SunXe/mIKw/qsNIkC2alUNUuwKdBvkSLwMDaBDbn8qkjy
        C294fcAONPf++vuOH4/9d/M=
X-Google-Smtp-Source: AK7set+25e0jiz/QfBLhshopEKwFYJQZdMjPeDw15rvcubhtLK1wub6a7200Hu9ZmXQIk7BdoxUBNQ==
X-Received: by 2002:a17:906:db05:b0:889:5686:486a with SMTP id xj5-20020a170906db0500b008895686486amr22406068ejb.30.1678280639119;
        Wed, 08 Mar 2023 05:03:59 -0800 (PST)
Received: from [127.0.0.1] ([46.211.69.230])
        by smtp.gmail.com with ESMTPSA id u2-20020a170906c40200b008e2dfc6382asm7445708ejz.125.2023.03.08.05.03.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 05:03:58 -0800 (PST)
Date:   Wed, 08 Mar 2023 15:03:57 +0200
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-tegra@vger.kernel.org, linux-staging@lists.linux.dev
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_7/8=5D_dt-bindings=3A_sound=3A?= =?US-ASCII?Q?_nvidia=2Ctegra-audio=3A_add_MAX9808x_CODEC?=
User-Agent: K-9 Mail for Android
In-Reply-To: <8c24e719-2ca8-4571-8d00-cc9d488d56ff@sirena.org.uk>
References: <20230308073502.5421-1-clamor95@gmail.com> <20230308073502.5421-8-clamor95@gmail.com> <8c24e719-2ca8-4571-8d00-cc9d488d56ff@sirena.org.uk>
Message-ID: <915E75D9-8D29-4A72-9E53-841D5A420BAB@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



8 =D0=B1=D0=B5=D1=80=D0=B5=D0=B7=D0=BD=D1=8F 2023 =D1=80=2E 15:02:28 GMT+0=
2:00, Mark Brown <broonie@kernel=2Eorg> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D0=B2(-=D0=BB=D0=B0):
>On Wed, Mar 08, 2023 at 09:35:01AM +0200, Svyatoslav Ryhel wrote:
>> Add dt-binding for MAX9808x CODEC=2E
>
>This is adding a binding for a machine driver with these CODECs, not for
>the CODEC itself=2E

Fair, I will update name in v3
