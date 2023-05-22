Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB02370CE4F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 00:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjEVWuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 18:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbjEVWti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 18:49:38 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DFB19BD
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 15:48:46 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E8A343F1A6
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 22:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1684795699;
        bh=Jxhv2lTtff9eVeJELEiAulXYDJtuSmfhKSrVPr6ETnA=;
        h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type;
        b=tvT93d4w326p5ZIYnCXCosIyI4VZw1NawzmBMxfKw6usnxidH3rrseWat7MMGKC4x
         xc/JWIThID9YYzm8YYH80xfLJ0G5LNmoAcU6yKJm01bDs8Bi/sC8K+LvBQCjqhGyiF
         qeEW7qh1WPtpGOuaV4nHeqRGFuVusnShIDOhCj0NuwjMQcXHOtRKZAGT5FGt/7+5h/
         Am6BL06442brf5go1zpabnw0JeKkCig9bH0ZsiJVmtCw7bG2aVNtQ2FwPUMMyMC/6D
         6bBK/EvnDrhbDP+pbJsbcnb+gXBNswDPvI3gsYI2/mHPrptm6E0wjjkcsQl+LdmuSE
         HNO51QsQkpjyg==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-96fd6bd135dso219862966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 15:48:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684795699; x=1687387699;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jxhv2lTtff9eVeJELEiAulXYDJtuSmfhKSrVPr6ETnA=;
        b=hY9tbjXdi8Gi4JjYZjyZwfwXdEW8ftInG0tnN6zd948fYQDmOzv6Pu9Y/m9Zk9XU+U
         xW1Lp38ebsDB7t/bno8EugvIZcEo7T9gCBwskmp+vtxBvzhzVbczgwqhhOS7gNfBqIUd
         0oSYHFy/RHjpxwZNojrSu534PmFetefR/oQc4Fe2Qhb0iKrgq3qSHEqmfqStuk7zMdYZ
         g4cTVdw5qhJ4A442kqkMMigTa8JFYYoh5l3sWvDYK9yBEFlMXjfZc4fSfF17RXpyrswf
         gMYrPZc2ca+CYRPRMhs/srD8sZnHUlSsGpfaFPUZNSYQNn/c0ylgDRwGshpJz1wyxN7T
         CnmA==
X-Gm-Message-State: AC+VfDwWdWOVlBr7ma3dW/WmKX8Kt8mIExafOKfN4H4b97pSB+SkGys5
        E/WxLoqeygL3IVWWH/yntK9Smj6CmtxC3REyZf+iVt8wTOY9ZQzYpnGt3Uzvg2MrBU0QNVCCPVC
        2ldiihFzPzcDG4/b4HeqPciZ7e3DG5a/uFOQq0jSSikYRMg70aw==
X-Received: by 2002:a17:907:2d8e:b0:96f:f046:9a92 with SMTP id gt14-20020a1709072d8e00b0096ff0469a92mr4424239ejc.37.1684795699316;
        Mon, 22 May 2023 15:48:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Qs2GhSqufUN/SZtD4ZFFc6BIBGnxyXjfnMSVzpQ2DvGQ05aav/CjUeUgU+RgM5wbIf/9jXg==
X-Received: by 2002:a17:907:2d8e:b0:96f:f046:9a92 with SMTP id gt14-20020a1709072d8e00b0096ff0469a92mr4424230ejc.37.1684795699061;
        Mon, 22 May 2023 15:48:19 -0700 (PDT)
Received: from [172.16.80.41] (10.238.129.77.rev.sfr.net. [77.129.238.10])
        by smtp.gmail.com with ESMTPSA id l20-20020a1709065a9400b00965d4b2bd4csm3682819ejq.141.2023.05.22.15.48.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 15:48:18 -0700 (PDT)
Message-ID: <4ae6d363-2f9b-5028-db1a-061b6f1e8fbe@canonical.com>
Date:   Tue, 23 May 2023 00:48:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Olivier Gayot <olivier.gayot@canonical.com>,
        Daniel Bungert <daniel.bungert@canonical.com>
From:   Olivier Gayot <olivier.gayot@canonical.com>
Subject: [PATCH 0/1] block: fix conversion of GPT partition name to 7-bit
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

While investigating a userspace issue, we noticed that the PARTNAME udev
property for GPT partitions is not always valid ASCII / UTF-8.

The value of the PARTNAME property for GPT partitions is initially set
by the kernel using the utf16_le_to_7bit function.

This function does a very basic conversion from UTF-16 to 7-bit ASCII by
dropping the fist byte of each UTF-16 character and replacing the
remaining byte by "!" if it is not printable.

Essentially, it means that characters outside the ASCII range get
"converted" to other characters which are unrelated. Using this function
for data that is presented in userspace feel questionable and using a
proper conversion to UTF-8 would probably be preferable. However, the
patch attached does not attempt to change this design.

The patch attached actually addresses an implementation issue in the
utf16_le_to_7bit function, which causes the output of the function to
not always be valid 7-bit ASCII.

Olivier Gayot (1):
  block: fix conversion of GPT partition name to 7-bit ASCII

 block/partitions/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Thanks,
Olivier
