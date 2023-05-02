Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C96B6F3DCA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 08:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbjEBGup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 02:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbjEBGuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 02:50:40 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237411FDE
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 23:50:31 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230502065026epoutp041832bfafac6c311d4512b31c03190900~bQOJgaq6z2484424844epoutp04k
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 06:50:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230502065026epoutp041832bfafac6c311d4512b31c03190900~bQOJgaq6z2484424844epoutp04k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683010226;
        bh=q9YWqwZshFXhhq++WvNm/JUJLCR4C19Tey40Db2nw7w=;
        h=From:To:Cc:Subject:Date:References:From;
        b=VIjERLHDZt9FIYLDE9JVnU5Jt//bQgMawr7/6ANK0CnAOVyYX1Wht/AjLrDLdPTL2
         REBgrV+zI5rEw4xXSEPF91SALtVhsHq2/8l8AREcpbbOrJQUZZUJz5kdnP12VIEXgV
         /wYQ8yCwkrGUy9ge7y6eOpnhJajqelKO0nlyj5Po=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230502065026epcas2p468274824a65607dd394f196d155da44b~bQOJKxcrM1117111171epcas2p4E;
        Tue,  2 May 2023 06:50:26 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.90]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Q9W1F5Rq3z4x9Q3; Tue,  2 May
        2023 06:50:25 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        C4.E4.22936.1B2B0546; Tue,  2 May 2023 15:50:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230502065025epcas2p16f5a02e6990d6f2b2257f001979ebcf9~bQOIIAqlX2045420454epcas2p1g;
        Tue,  2 May 2023 06:50:25 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230502065025epsmtrp257d1b0d3cc600b53bd3239fd4365d404~bQOIHVFyF2944229442epsmtrp2L;
        Tue,  2 May 2023 06:50:25 +0000 (GMT)
X-AuditID: b6c32a48-475ff70000005998-ab-6450b2b164e0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D2.C8.27706.1B2B0546; Tue,  2 May 2023 15:50:25 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.55]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230502065025epsmtip1b3cc80aaa95a3bd11030231e839d2e77~bQOH5jt0l1187211872epsmtip1d;
        Tue,  2 May 2023 06:50:25 +0000 (GMT)
From:   Jaewon Kim <jaewon02.kim@samsung.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH v3 0/3] Improve polling mode of s3c64xx driver
Date:   Tue,  2 May 2023 15:28:10 +0900
Message-Id: <20230502062813.112434-1-jaewon02.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEKsWRmVeSWpSXmKPExsWy7bCmme7GTQEpBst+a1s8mLeNzWLxj+dM
        FlMfPmGzuLxf22JHwxFWi72vt7JbbHp8jdXi8q45bBYzzu9jsmj8eJPdgcvj+pJPzB6bVnWy
        edy5tofNY/OSeo++LasYPT5vkgtgi8q2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0
        MFdSyEvMTbVVcvEJ0HXLzAE6TEmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYF6g
        V5yYW1yal66Xl1piZWhgYGQKVJiQnfFh3zz2gl/sFV8OfGBrYFzO1sXIySEhYCIx6fwlJhBb
        SGAHo8SVI0BxLiD7E6PEszm7GSGcb4wSe/79Z4HpmDlpLxNEYi+jxNbz/1ggnI+MElO3QFSx
        CWhLfF+/mBUkISKwmFFiwdWd7CAOs8ANRonuN5vBqoQF7CQWTfvMDmKzCKhK/Jp3FewSXqD4
        z9aTUBfKS6zecIAZpFlC4Bi7xOWuqewQCReJdZ3TmSBsYYlXx7dAxaUkPr/bC9WcLdE+/Q8r
        hF0hcXHDbKi4scSsZ+1A33EAXaQpsX6XPogpIaAsceQW2GnMAnwSHYf/skOEeSU62oQgGtUk
        7k89BzVERmLSkZVQB3hIHHr/gx0SjrESp+a2sk1glJ2FMH8BI+MqRrHUguLc9NRiowITeCwl
        5+duYgQnNi2PHYyz337QO8TIxMF4iFGCg1lJhPdDoV+KEG9KYmVValF+fFFpTmrxIUZTYHBN
        ZJYSTc4Hpta8knhDE0sDEzMzQ3MjUwNzJXHejx3KKUIC6YklqdmpqQWpRTB9TBycUg1Mup2x
        nBtv3l3JUnJgW4bE7TQvrQ0l7xdVBCnZW4pM+vBXKCupZ+nMyPmaTuq/jlg4V17WENm2rN2p
        4NHD4osXZwgfa3r/4ur/vVwzK7Z23d1zaGP5Ws+K6KxkUaXlc/jlaq8mMcqY783gmWS/psGm
        /H51PY/DZRW3nNwHS9W9LV0XX+cpb9kZpfTxcqXYkXWdaTLBvwJm312178Q57tuFt7kuCV54
        76MlsaVLecOKm63zZvfxXHNxsj1du4xx2avHkwssbj+POxnT8UK8X2u6S9Pb9f8fq72Y5WYv
        8V+34Lcas8nPG9PzNxts9F+UeyK//ZLR4oJFB88UpsaX/wzmTVso8/T3/lwPrbPl37dNUGIp
        zkg01GIuKk4EAK0SIjv1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMLMWRmVeSWpSXmKPExsWy7bCSnO7GTQEpBmsu8Vk8mLeNzWLxj+dM
        FlMfPmGzuLxf22JHwxFWi72vt7JbbHp8jdXi8q45bBYzzu9jsmj8eJPdgcvj+pJPzB6bVnWy
        edy5tofNY/OSeo++LasYPT5vkgtgi+KySUnNySxLLdK3S+DK+LBvHnvBL/aKLwc+sDUwLmfr
        YuTkkBAwkZg5aS9TFyMXh5DAbkaJr/MnsUAkZCSWP+uDKhKWuN9yhBWi6D2jxKPrP5lAEmwC
        2hLf1y8GS4gILGWUeLznMQuIwyxwj1Hi5aRvYFXCAnYSi6Z9ZgexWQRUJX7NuwoW5wWK/2w9
        CbVCXmL1hgPMExh5FjAyrGKUTC0ozk3PLTYsMMxLLdcrTswtLs1L10vOz93ECA43Lc0djNtX
        fdA7xMjEwXiIUYKDWUmE90OhX4oQb0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1Kz
        U1MLUotgskwcnFINTMUNLM+/rGPvuXh/ZUb3i0s7r70+N/Vvg+q3k/c9ml7tmMEdcSA4Zb7o
        zYnbYw9e0yrYsi94r7az3lUhtbAbfy92exjc3xBsoh+xtpE17axOexqbgvdpR0eTvzyF9Zsj
        XLxvP5paY9jsnt6j3ptqICdefNxKart3f9rluMeb+Y+ITvu18l/19zUidUY/390M5uSRr2o0
        FO84p/v1jcAtvvmdwoo5Bhv23DzcdzKw6RfDtojWarHfkTnBKYKS0ycnvWuZz5hWPrNy8e8Q
        Yd9lnRP+ZtVn5xwu9WB5dsbaIfqLme93t9Ni2xcKc0XeXvkoZdHqFVLPAnwin/8rijump/HQ
        dr96xoFg5dvM/Tz5SizFGYmGWsxFxYkAFe8ZnqYCAAA=
X-CMS-MailID: 20230502065025epcas2p16f5a02e6990d6f2b2257f001979ebcf9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230502065025epcas2p16f5a02e6990d6f2b2257f001979ebcf9
References: <CGME20230502065025epcas2p16f5a02e6990d6f2b2257f001979ebcf9@epcas2p1.samsung.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, polling mode was supported as quirk for SOC without DMA.
In order to use it more flexibly, it is supported when there is
no dmas property in devicetree, and the issue of using excessive CPU
usage in polling mode is solved by adding sleep during transfer time and
supporting interrupt mode.

Changes in V3.
- Fix patch commit message.
- Change of_find_property() to of_property_present() with code cleanup
- Remove cpu_relax() related patch.
- Changes use_irq variable type to bool

Changes in V2.
- Switched to polling mode if there is no dmas property in devicetree.
- Add cpu_releax() in polling loop
- Add lower limit in IRQ mode

Jaewon Kim (3):
  spi: s3c64xx: change polling mode to optional
  spi: s3c64xx: add sleep during transfer
  spi: s3c64xx: support interrupt based pio mode

 drivers/spi/spi-s3c64xx.c                 | 81 +++++++++++++++++++----
 include/linux/platform_data/spi-s3c64xx.h |  1 +
 2 files changed, 70 insertions(+), 12 deletions(-)

-- 
2.17.1

