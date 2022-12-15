Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E67F64DD3C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 16:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiLOPEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 10:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiLOPEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 10:04:21 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055912F03A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 07:04:20 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id t17so52924638eju.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 07:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBdbSsBCIDSXtIT4Ck/YwIc9LJVDW1+QXULCh55/Xjs=;
        b=CmSNoPdukj2TPTk41/jidByPlJsyDesn2COgdAbNIsb59Dy5zt7uUbNdkRJ29Q0aZ1
         /3veEx/m9x3HsaequAxQYbsrr0mCLn+klQrPIgGHHhqfb8o8+8aHy5Y4rUc7GuH4iQOY
         tjscC0DYqu14Vs7BRI90jKad0MZ11Dlzj2tNIGO/P3WHb1GL0k3XXjQTGKX487H0dXDB
         iny5ljGdtPV/2opY+g641d9EMsxQzRgRjlMuTbqFkUe5yWFbOwR0ZGDFLaSva27XrS2b
         Ifv/RTYox3RBAbN+Zm8r9k1e/HmGZ+JlSgJOe9Q403d0KHHWvYC31m/pu/6IChavZC+d
         9osA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RBdbSsBCIDSXtIT4Ck/YwIc9LJVDW1+QXULCh55/Xjs=;
        b=2dJ3C0vIwMNlbvRjgMKq12I9Y9HOPxZrry1Zilhmo46sLIwDjxNV7iIlcySXo84M+B
         +saFMtwIy2gJWK1IEZJNApmv60Wht5dwJHLm+SSwPUTXzhwtBFPkcz6uG5CStr2m+vWN
         pNJzMNAotQApXxEeRaxkdtQW8RZneXgX+YrlLqPiZaTVbpUiDQPhdCHSJg2/BGk/nkJa
         wBJBUn3PBiK2d0HSK4u0i6MwOvh8Fdg+Z3b1Wq8FZB8V0I3Ui6ZZ/y1X8109oMRt6YCT
         vh+zxJ7Gymscd3ZkiuHOabf88v6/eH5oEA5E4d+0Ay7EZVETAhD8CPuFOg/qVE2/z/1y
         1HHg==
X-Gm-Message-State: ANoB5pnmeaupmG7QUmw5hTB2Bj4IlVaLaWsIg72UIoPd+l9Buao6aHb+
        Qj2EI/NFwWbbclO+y4/e5ZhKDA==
X-Google-Smtp-Source: AA0mqf5s5MfLEyckD+E8WOI+15ldRwGc4goDBOInO9jYsUvKNOJoQEO4/gzsdZqJUEoz9NjlXcRkCA==
X-Received: by 2002:a17:906:8d08:b0:7c1:3a0:c0a9 with SMTP id rv8-20020a1709068d0800b007c103a0c0a9mr22290672ejc.12.1671116658584;
        Thu, 15 Dec 2022 07:04:18 -0800 (PST)
Received: from mbp-di-paolo.station (net-2-37-165-98.cust.vodafonedsl.it. [2.37.165.98])
        by smtp.gmail.com with ESMTPSA id wf9-20020a170907d68900b007c4f500c8ccsm1866022ejc.6.2022.12.15.07.04.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Dec 2022 07:04:17 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH V10 0/8] block, bfq: extend bfq to support multi-actuator
 drives
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <7125ff61-bf11-6f8c-8496-f2603371c214@kernel.dk>
Date:   Thu, 15 Dec 2022 16:04:16 +0100
Cc:     Arie van der Hoeven <arie.vanderhoeven@seagate.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rory Chen <rory.c.chen@seagate.com>,
        Glen Valante <glen.valante@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3479E7A6-8CAD-4A32-A0BB-00A851883EA7@linaro.org>
References: <20221209094442.36896-1-paolo.valente@linaro.org>
 <A0328388-7C6B-46A4-A05E-DCD6D91334AE@linaro.org>
 <0bcf7776-59d7-53ef-bfd0-449940a05161@kernel.dk>
 <PH7PR20MB50589A941F3F5A50C872E264F1E39@PH7PR20MB5058.namprd20.prod.outlook.com>
 <7125ff61-bf11-6f8c-8496-f2603371c214@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.11)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 13 dic 2022, alle ore 18:17, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> Please don't top post...
>=20
> On 12/13/22 10:10?AM, Arie van der Hoeven wrote:
>> We understand being conservative but the code paths only impact on a
>> product that is not yet in market.  This is version 10 spanning =
months
>> with many gaps waiting on review.  It's an interesting case study.
>=20
> That's a nice theory, but that's not how code works. As mentioned, the
> last version was posted 1-2 weeks later than would've been appropriate
> for inclusion.
>=20

So, what's the plan?

Thanks,
Paolo

> --=20
> Jens Axboe
>=20

