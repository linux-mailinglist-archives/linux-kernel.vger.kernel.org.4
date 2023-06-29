Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1225741EBF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 05:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjF2DdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 23:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjF2DdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 23:33:10 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85ADA271B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 20:33:06 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230629033303epoutp01236b0dbb6446b4d7e59f827abedb472d~tA8XSyqzh1266212662epoutp01H
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 03:33:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230629033303epoutp01236b0dbb6446b4d7e59f827abedb472d~tA8XSyqzh1266212662epoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1688009583;
        bh=u5DsHg6ggkF/1rIcP6TAqj75zRX9a4htppIh4mOdKpo=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=p8idRiEPX6hYP2oqqWGm+6m8nfQ34BAibhoqSBXnBMaLmzKhWamh8qjGkUI9ACQCb
         SZUkSYVOPPNYneDb7G4Jb4QgZGi0kgxT0Inqr/TbRZJgqhHgYeFmWAnmA/prU3nSNz
         3AOC8i7IQ7MJxQ4+e/c8D4y7lTpSueQCnZAdIQZQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230629033302epcas2p33d0ba10ec94e85602736e0c461ff1e28~tA8Wrz7Pn1597615976epcas2p3h;
        Thu, 29 Jun 2023 03:33:02 +0000 (GMT)
Received: from epcpadp4 (unknown [182.195.40.18]) by epsnrtp3.localdomain
        (Postfix) with ESMTP id 4Qs3tk5s9nz4x9Q0; Thu, 29 Jun 2023 03:33:02 +0000
        (GMT)
Mime-Version: 1.0
Subject: RE:(2) [PATCH] scsi: ufs: Optimize the WB flush process to save
 device power consumption
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     Avri Altman <Avri.Altman@wdc.com>, Lu Hongfei <luhongfei@vivo.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        Keoseong Park <keosung.park@samsung.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "opensource.kernel@vivo.com" <opensource.kernel@vivo.com>,
        Tang Huan <tanghuan@vivo.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <DM6PR04MB65757599481E7CAA98D89CE1FC24A@DM6PR04MB6575.namprd04.prod.outlook.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <1296674576.21688009582803.JavaMail.epsvc@epcpadp4>
Date:   Thu, 29 Jun 2023 12:11:52 +0900
X-CMS-MailID: 20230629031152epcms2p178df92a3dce855dca2c661bed5d2a272
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20230628110055epcas2p2c957a4a995635c8e9280958c9a34a8f6
References: <DM6PR04MB65757599481E7CAA98D89CE1FC24A@DM6PR04MB6575.namprd04.prod.outlook.com>
        <20230628070229.61855-1-luhongfei@vivo.com>
        <CGME20230628110055epcas2p2c957a4a995635c8e9280958c9a34a8f6@epcms2p1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> 
>> In the original logic, WB Hibern Flush was always on.
>> During suspend flow, the host will determine whether the device needs
>> BKOP or WB flush, and if so, it will keep VCC supply.
>> WB flush is only a part of BKOP, and device that needs BKOP do not
>> necessarily need WB flush if the conditions are not met. Therefore,
>> if WB flush is not needed, it will be better to disable WB Hibern
>> Flush,..... 
>I beg to differ on this conclusion.
>If you expect SLC write performance, without fluctuations,
>the host should let the device manage its wb buffer on its own.
>This is exactly what flush on hibernate does and better leave it be.
>
>Thanks,
>Avri

Hi, Lu Hongfei.

I agree with avri.
In fact, I am not sure if there will be a significant improvement in
power consumption.
In addition, for the toggle of the function, a code that compares with
the existing value must be added to prevent unnecessary queries.

Best Regards,
Jinyoung.
