Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550616C39C8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 20:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjCUTF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 15:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjCUTFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:05:55 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D78E567AA;
        Tue, 21 Mar 2023 12:05:25 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32LIhn0B024096;
        Tue, 21 Mar 2023 12:05:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=dC8hJGAL6NNll1VJvUaeAr2aiwvdxjoKuMN4v8Y1HYw=;
 b=vvn5DhlPEFga5SK84VbZarb4WAlQrPa8SD2iwBN/dQUYMDj6/UGq4GEewqutClkYI7Sb
 k7hx42h1h1z4pHYhkGO7ljrI2uhS458xLq8dy+VfRnGvFp8ZiWvu6O6Rlu1C1/JrXPAn
 vQyzERUreSwxkntO5tZldmw0PlCAgbvwEhT4Ywn7VglM3ZUWTYPwtECrJdx4kobJKKal
 VXG94hM2xb1u0dJmE2necPSsxtBgL+eMd7VjkwoDWPH//OGxBuFofGAz6s9Ji2NFON6O
 Xr4X+bgJxDLikXVTn1Dpp/LGUFxGjO30enouNMff3RzZflMOLsceFmYnKxmrM522m/nk cA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3pdbxgr7ut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 12:05:10 -0700
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2EDD240099;
        Tue, 21 Mar 2023 19:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1679425509; bh=dC8hJGAL6NNll1VJvUaeAr2aiwvdxjoKuMN4v8Y1HYw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=BweYYgcIQb6b8CQku4dwKUgafratXNJpQfjz4U2gZZjC9msWSNZRy+ifxs8wG5g8W
         cOXoNz87C+oro+pMikBahdoEj+zPjMPrLlGqSOUSy/F3p1UqcGVl3Mot7nZA55mpN/
         Xojf4md0d709jvk0QDX0s5KnLoV5zVbV1AfZHg7lEgbN/WfkdTspYW83UwrFNnSzL2
         XKzaEx0t5g6S8PGtAi0goyezToU4AeoCwsHDLQhOv1JkR72LQdVMbqN+gZGJNC+gAK
         1rvbwBN0YNzic+E14iur8OgZ73p3sJMoJ+9KhwpWU9ZcFML//9AelWKgPAm9jQ0YO8
         2J0L49ajnV2ww==
Received: from o365relayqa-in.synopsys.com (sv2-o365relay7.synopsys.com [10.202.1.143])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relayqa-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 41EA4A0063;
        Tue, 21 Mar 2023 19:05:07 +0000 (UTC)
Authentication-Results: o365relayqa-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relayqa-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relayqa-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=eCnizldY;
        dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relayqa-in.synopsys.com (Postfix) with ESMTPS id 0645E220414;
        Tue, 21 Mar 2023 19:05:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCpLIN9gZZgLmmLQQHFyZdFgUe9PjREh1g+BBNwBDycwc4tTpLRPkoLm5lJTIqm9LeMwFhchI6nJPXN8j211QMipOAc+D3cm/UuTlYpwmX1nnCnUaWYNqVzVzDQzB5mgzARJ4jwYEKkczvLCGAwyIxMkXm0duOIoR+ud7dVJTZkgZAWjg/K2ZKcmFeRkU7nPZWQw1+tMEpFqDf08HrmPb3W+RXEm1BtXXEKTvBkWbhFgQXvlCClgQnnsLuDTZDRFQpQQEjd/atPKm+Cjfu744ihTbYpqJ+jSqiUatm6upfJ910mqQTQtr01YHW0Yx4pZOviyQcFJYkjcOIK328gx6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dC8hJGAL6NNll1VJvUaeAr2aiwvdxjoKuMN4v8Y1HYw=;
 b=dt5mR8tBv9xzObwJRZYdu94UTPWOL6Wi6xmH67zRWgu1ZApDnOT7FS2vIQS+WotmNYBdeIuL03fC8TbBrTi3VvfCbyQ3E5rqhdAu2/yXO66yfrRmD49osynJ7H7OBoGGhEjldNUbCBn9wh0SrfVryqJnO2Rn7Rz14pAaU8W9O+osg2pcWW/PTMgt0vvKbtYaDRNhta6nCsLk16K0YFrjVKucOvxQZshxC83aKsIMlnd3C2nuT//w7oNR1qOhwHgA5/XFsFv0+E6hEgTEzf/wORafMITZTGdwMZXFSl+ds/mFGjLQ1f8apQHI7a6TBLAh/rzkiLLK4XgRAtRUJ3Zi1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dC8hJGAL6NNll1VJvUaeAr2aiwvdxjoKuMN4v8Y1HYw=;
 b=eCnizldY5/+EEsQKvg0CiQtQ6JN13ZKo0pSu6dQU2renZeazLundMD+uwPeVaqD8vk2nYSjxeX3X5ighzlBIT6Uh0kKQ7lE7i7K5jPTLY+SFNVJ3mqc1oyHzqCLfTynl1yqZsFCj7gJkjjCRe0d6Dppz2JVjRkyP5I9ddGnOCfU=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BY5PR12MB4275.namprd12.prod.outlook.com (2603:10b6:a03:20a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 19:05:04 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 19:05:03 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Roger Quadros <rogerq@kernel.org>
CC:     "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "vigneshr@ti.com" <vigneshr@ti.com>, "srk@ti.com" <srk@ti.com>,
        "r-gunasekaran@ti.com" <r-gunasekaran@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/2] usb: dwc3: Support
 'snps,gadget-keep-connect-sys-sleep' feature
Thread-Topic: [RFC PATCH 2/2] usb: dwc3: Support
 'snps,gadget-keep-connect-sys-sleep' feature
Thread-Index: AQHZWw9BydGhQRYXjUGBS+C5GU6+168EBAMAgAEDRQCAAIy8AIAABewA
Date:   Tue, 21 Mar 2023 19:05:02 +0000
Message-ID: <20230321190458.6uqlbtyfh3hc6ilg@synopsys.com>
References: <20230320093447.32105-1-rogerq@kernel.org>
 <20230320093447.32105-3-rogerq@kernel.org>
 <20230320185206.a4o4bmhml7rlg6f7@synopsys.com>
 <48814d21-24d9-3141-68c8-316d071de1a8@kernel.org>
 <20230321184346.dxmqwq5rcsc2otrj@synopsys.com>
In-Reply-To: <20230321184346.dxmqwq5rcsc2otrj@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|BY5PR12MB4275:EE_
x-ms-office365-filtering-correlation-id: 54b41055-2bbe-466d-40b8-08db2a3f2cfb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vjt5x43m8SBbBavavAYhS8QnX8myGl96XeYIQafCNO6CG4xvdm2Ly0XjemW00TamxQYbyzet6/jyYscm39SNYyHoH64HebqVwYa0ZomMCuoxUzFO3ydd8A0/TS4yXS5H38/dp7mCPHFxxvX3CDYzUedjSfwLnSDCXDneNBzNk0YhHosLDb4WWxhxvQkQf2CsllN3mp9ZMpWl04E7SWzXn23Wt8q/bPSUQglOzou8TYVJTbsWgQvq86lqnJZkTwg+02lSd1eFVdKIcVeMqQf9eFsZ0m8x1NLDAFL1u3chwL6ezp4nWo0mqkXbp98kLi6aA2zPvqpImNw13WzZhSfEjYuametiL6cveiOdpvP5XMN2+yP2S5hNUbjocleDAQkk/8iG5K40A+tYqxLKCMO0KbrMYGKVqxwKikU5gTR6+q2eq2SdkYOL7IYdkMOi39C27I8DSz6J1wG/CK5/NOY2hbNmmzcYq0XZhd7/5v6hWkgv03bE1cwSuyYhnf8ubFjbd49p7uR4+PAIpA8GBezaKb2FXZQoql2mxa0vUs03yMfXvK4CeTSvy0PmfLSCaith2Xt2dvgUHpu++TEvcJctStzEXC+/VHTYZa2pGlsgMGOKmqHBpD53I5k2Wc2VefyxsK63F7SqIyfhcNAfQZ2ZCGtFzHEnYiEZJyeU9KmtWsF6L1X7WZiim/pXdXac+McZxYWMEwWm2Uu9e5OEdaguxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(366004)(346002)(39850400004)(136003)(451199018)(71200400001)(38070700005)(41300700001)(8936002)(6486002)(5660300002)(66476007)(2906002)(186003)(122000001)(38100700002)(316002)(478600001)(2616005)(6506007)(6512007)(1076003)(54906003)(4326008)(26005)(86362001)(36756003)(53546011)(83380400001)(66946007)(64756008)(66556008)(66446008)(76116006)(8676002)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWp2UjVhbzc4ZktoUTB6RjlyQm5KWFNOalp0aUdkZEl0aHFJSzFDSUNLSmxl?=
 =?utf-8?B?UjlqeTE5Uy9yRVhSS1ZaYlhKSlpYSG9pZ2h2Vjhzd1d4Q294WGxwQVNrSWVB?=
 =?utf-8?B?aGQwS3BGOFJ1ZklwYlNMY3BpU3Y1VTFVMmV0M2dBRk1jUy95Z2xhSFhINmRU?=
 =?utf-8?B?MncvdFp2OGVqdkpWS2NUNVVrR0dPUHRjc2k5OG5wS1lFbFhweGo1VDFRaFRm?=
 =?utf-8?B?V3dPT2RRRTh0bC95MGdjZ0dETkFzT2xReGpMV3l5SkJVRFVNeUFJQWZNOWRL?=
 =?utf-8?B?OFpCZTBobFBOSGNRSTk4MG10dGJudjRMTUU0S2ZxQWVPMlE3aWRmNDBiYWRz?=
 =?utf-8?B?OEpTREJBa1pHWW53MG5YUUJMUkdvakM5N1ZRRG1qKzNOdDhyYVRIbW1qWG9S?=
 =?utf-8?B?d2MwZENiR3A1VnRyTzArNk13WHlZVVdnOVdERitnT1dtalRzQzNKbkhKT3k4?=
 =?utf-8?B?TVRxVWF0YXFRcHNFTGRqdGdzY1dkdHJvWkkyNDhUTE1WUDlPbytXQUF1bUNS?=
 =?utf-8?B?L2NMODVNNXFabDFOYjJqTldyaHNJd1EwQnBsOEMvNXZtbVBERHM1SEFzVmJr?=
 =?utf-8?B?dnl6cEVHTXkxSDZuS3Q4alBVYVAxZjY4aWlVZzJLcWNWL0pXQmRkUmlLMzNZ?=
 =?utf-8?B?dGF0djNkbE1UVnlBOUE4eUZROWg3Sm1kLzRCQnBtQzhiNXZ5MHdvT0JzQWp2?=
 =?utf-8?B?bXIrY1pBR2xTbENwL3FTRG1wY3RBekY2WklzazY4VnpnazFlWlYrM1UyRmxB?=
 =?utf-8?B?ZnFpOVJHWWpjZTlJaU8vZW50UlZjOXZJdnZWeEcyQ21ka3BSYkNtUmhDTGs5?=
 =?utf-8?B?RFZqMjRjczNlK2RDMFJHaWJjS0dmRmFjQVprWm9TQkl6Ri9UQ0NxNUt4ZDJP?=
 =?utf-8?B?ZFJ4RU9NOEdPZnJ4bmpwWERUS1BDdlhORFJteWFESW5kWGRsL2I5WENwL0tP?=
 =?utf-8?B?N0h4Vi93Zm0xK0l0Umd0SUltdEY5eUxCVEtONG9hQjJXQ2JDSE16TUNJRnZW?=
 =?utf-8?B?VVE4Y0lqNDVBWDQ0QkptcnFJajFoZGNORWwwVTdvSXVETjM5NlNGYkRoOVdQ?=
 =?utf-8?B?OTdiMmxHaHFiS05hQVlHNWZvemNqWHluSDEwT3pjN1UyTjlJaUxubmxMazRC?=
 =?utf-8?B?cXAxL2czNm12T3VpVjhoM0pwSDY0b1FZY0kwdjlJY2RIc1JKc1FkRDZxZGF4?=
 =?utf-8?B?SUlWa2ZRYXlYZytqRjRtVVE5T2dzRWNvWVIwQmhZbTJnNklqMlRTd3o4K2xz?=
 =?utf-8?B?RlhlMXduNE9QODVoTFFxYXpNS013KzhES0dwWnJUb3gzbkVBakt5V1R0Rloz?=
 =?utf-8?B?VzVPcjA3WjYzWmlYbU16OWljcnhWSWdqMTc2dkdndlJEZG5rVTd4T003QzNk?=
 =?utf-8?B?ejM1Sy9obTNDY3FOejdTRHc0MDg0M1JiMXhFWVYwbVh6dXp5YTRmbnBHYUZU?=
 =?utf-8?B?Rm9lZHJKYU5RVjZPNGQ0S0JpM2lRZVFZQmFDMTJ3aXlmcVZUMWlmWlprS0lk?=
 =?utf-8?B?Z0RmeFZiK2Z1RkJPaEQ1UFgvZjF0azkwUVF2cmZmZnNSa1JtYzB2dVR6cGI1?=
 =?utf-8?B?Nit6Wk1nQ0srQ2tuWlNtV04rb1lJeXFVMG5mZ25HZ2p3bkpscHd5OEpJWDFv?=
 =?utf-8?B?bXBhdkh1ejR6aG9GV0dhSGp2NFAwZW1wK0JxRWpMcEpUakEvc0IzaFlHTU80?=
 =?utf-8?B?VFZHVkpmaU1LRTliZDEzak9rcGxDak5yMHFWayt4ZHNKVUhCaDFPMzRrQjcr?=
 =?utf-8?B?cCtjT3RrMjMxRHl0T3JwRlNLMkRzTHpUT3Zqd2ZrQnJvY1VQc25xdGFzbEFp?=
 =?utf-8?B?R3ZqTDRiSllGcjBqWjdmQ1F4eW1PWjhTVFpvdzFxdUJNSVh3Y3BLVTYwcHph?=
 =?utf-8?B?VWlaNkV6L01GbWlZd3dISk4wQ2JTR3RFaDUraGcrUldYNXNmRkc3OEhCbDNi?=
 =?utf-8?B?ekl4QVpHYUR0UWEvdnVwSW12QTVlb0tDMStDanJVdk5vdGRJWmVMdDNtbTY2?=
 =?utf-8?B?VFdIRjBPclJ3U3pOWkZINDdGamRBTU1DYmdNVDFPZStheE1zSkF2M1BJNDg2?=
 =?utf-8?B?S2lmRnZENlMweUZtMUtwOEMyZG5HaWs1Y3N2ZHBubFZ5cW44dFF2SUlHb0hk?=
 =?utf-8?Q?qhZpTnhGod/Is2m8x1nsGO6lj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFE2E1515F4BE147AA2493A19E82E4EA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?eit2ZTVMMVVQbEViU1EyYjlsY1V3WDBRdU1aOGI5MFRzSjRRVVZKTjNwekxM?=
 =?utf-8?B?cEx5dndkT0RTeHJRMlZ2RU1TZ3dKOWZYWFNsdjRSS2g0UUE1MjRYWFVoNktH?=
 =?utf-8?B?alFGM1BVZ0VqVER3SW9XTnJkRUpXb05XZUxVMEgwZlkvd1FPYTd3b0RwKzZD?=
 =?utf-8?B?cVpnSHlUR050c1VObVovZW1NbjRwdUdkTys1czREaGg2UmRtb28xb0QveWxJ?=
 =?utf-8?B?cFc4ZXYxY016SHNUUlpKbjBrelUzQUJJd0ZZTUo0ZlhDT0EyRDM5ZVQwWFVH?=
 =?utf-8?B?dzFacEJWbEFqbDBhWGIwemR0Z1B4ajFyajdhQ0FxMENuUHpTcWRyNDdNbVBa?=
 =?utf-8?B?UDl5RGd1OW5uQ2dCT1l0bXk4ZVIwZnl0cTAzWDBnY2prcTBJZWg3RlNGd2pD?=
 =?utf-8?B?dER2YSt1TlF1WDZVYWU0L2lFNGpsbThqLzk0Z3VGdzV6Q1BMSktvSXExbWIr?=
 =?utf-8?B?MzQ3eEMzM1lsRmtOc2V5K2R5WU9PdjZmL0liVitwZUhsUlg3OXZwa0dMeVlp?=
 =?utf-8?B?LzgvZDFxZXhZR1daMmNhK2JDQWZtOFJIMThvZG9uRHg1QzlhaDhlZGFhTzNq?=
 =?utf-8?B?ZXFhRTh5Z001YUJySTdpcEFkN0hzb2ZYVkxFU1FJeENlYXdOdXJmQ3lWdy9O?=
 =?utf-8?B?OG1QNFZTVm5XN3I5dCs0VzlsdG02eG43MUFPMEhOYXplNVlEZ2hSaTdjZkJE?=
 =?utf-8?B?aHJ6N3YxY2NjOVpWSncxUnd3QXhPd1BPbS9uNEUwYVVIM001YURHSkxCTWl1?=
 =?utf-8?B?Z2JySUpobmc4cnplQnlWMVFJbk9zRDRBTjQyUkx1U2tXZkRZeGRDOTJ2WDN1?=
 =?utf-8?B?TFBmcExnbjJTZW5hanozR2lxTzhUZDhndkN3NFF6dnhBL1NaQ2pjTEFTWDdW?=
 =?utf-8?B?S3NuSnZhNGRmNjliejFkS0RuOXNYMWJ5RTM5TW1oKzVDdHI1QllBUEFxNFdV?=
 =?utf-8?B?d1NoMW45cjRTbTM4dmVTWElSVk82V1FTaGpObVpiTHc5RWRaSnl5RFBRcXU3?=
 =?utf-8?B?SnZnQW1TN1hXL2FZZlVUNzZ1cVc1cFJHRjNZN0hKSEt3a2Q5NCtDVmF2WWVH?=
 =?utf-8?B?Rk1PNWJiSkdnN1g0YnZLVi9wTmFML0crcy9hcUhBMjErUGoyTTBGMUNqL1Fl?=
 =?utf-8?B?bkVyL3p0WG4xUDB4YmIvejZXamJVNmJOU3Q3a0FZNWZibTNSWFF6MjY3QThZ?=
 =?utf-8?B?NUFwTW0xb3RuK2dzTmczY3VQdUpGcjN6MlBkSkQ2R09FUGtRTGl2L0JNTHJI?=
 =?utf-8?B?VUVvM3czN1lPdndRUzQ4KytQQlV3c2pSYXFhSjhjMzN6OVQydz09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b41055-2bbe-466d-40b8-08db2a3f2cfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 19:05:02.8558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FfldzqU2D4BuwQJB+KAiq64cU3RjPfl7ycBmEomuWffeow9PomqgoAsppXw/gilWqbs+SDl+7XfUgv72SthRzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4275
X-Proofpoint-ORIG-GUID: m_2y_SJy1AhGa2gIEqb5VL9WSJsoUxcK
X-Proofpoint-GUID: m_2y_SJy1AhGa2gIEqb5VL9WSJsoUxcK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303210151
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBNYXIgMjEsIDIwMjMsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gT24gVHVlLCBNYXIg
MjEsIDIwMjMsIFJvZ2VyIFF1YWRyb3Mgd3JvdGU6DQo+ID4gSGkgVGhpbmgsDQo+ID4gDQo+ID4g
T24gMjAvMDMvMjAyMyAyMDo1MiwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+ID4gSGksDQo+ID4g
PiANCj4gPiA+IE9uIE1vbiwgTWFyIDIwLCAyMDIzLCBSb2dlciBRdWFkcm9zIHdyb3RlOg0KPiA+
ID4+IEltcGxlbWVudCAnc25wcyxnYWRnZXQta2VlcC1jb25uZWN0LXN5cy1zbGVlcCcgcHJvcGVy
dHkuDQo+ID4gPj4NCj4gPiA+PiBEbyBub3Qgc3RvcCB0aGUgZ2FkZ2V0IGNvbnRyb2xsZXIgYW5k
IGRpc2Nvbm5lY3QgaWYgdGhpcw0KPiA+ID4+IHByb3BlcnR5IGlzIHByZXNlbnQgYW5kIHdlIGFy
ZSBjb25uZWN0ZWQgdG8gYSBVU0IgSG9zdC4NCj4gPiA+Pg0KPiA+ID4+IFByZXZlbnQgU3lzdGVt
IHNsZWVwIGlmIEdhZGdldCBpcyBub3QgaW4gVVNCIHN1c3BlbmQuDQo+ID4gPj4NCj4gPiA+PiBT
aWduZWQtb2ZmLWJ5OiBSb2dlciBRdWFkcm9zIDxyb2dlcnFAa2VybmVsLm9yZz4NCj4gPiA+PiAt
LS0NCj4gPiA+PiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgICB8IDI1ICsrKysrKysrKysrKysr
KysrKystLS0tLS0NCj4gPiA+PiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmggICB8ICAyICsrDQo+
ID4gPj4gIGRyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgfCAyNSArKysrKysrKysrKysrKysrKysr
KysrKy0tDQo+ID4gPj4gIDMgZmlsZXMgY2hhbmdlZCwgNDQgaW5zZXJ0aW9ucygrKSwgOCBkZWxl
dGlvbnMoLSkNCj4gPiA+Pg0KPiA+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2Nv
cmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ID4gPj4gaW5kZXggNDc2YjYzNjE4NTEx
Li5hNDdiYmFhMjczMDIgMTAwNjQ0DQo+ID4gPj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3Jl
LmMNCj4gPiA+PiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+ID4+IEBAIC0xNTc1
LDYgKzE1NzUsOSBAQCBzdGF0aWMgdm9pZCBkd2MzX2dldF9wcm9wZXJ0aWVzKHN0cnVjdCBkd2Mz
ICpkd2MpDQo+ID4gPj4gIAlkd2MtPmRpc19zcGxpdF9xdWlyayA9IGRldmljZV9wcm9wZXJ0eV9y
ZWFkX2Jvb2woZGV2LA0KPiA+ID4+ICAJCQkJInNucHMsZGlzLXNwbGl0LXF1aXJrIik7DQo+ID4g
Pj4gIA0KPiA+ID4+ICsJZHdjLT5nYWRnZXRfa2VlcF9jb25uZWN0X3N5c19zbGVlcCA9IGRldmlj
ZV9wcm9wZXJ0eV9yZWFkX2Jvb2woZGV2LA0KPiA+ID4+ICsJCQkJInNucHMsZ2FkZ2V0LWtlZXAt
Y29ubmVjdC1zeXMtc2xlZXAiKTsNCj4gPiA+PiArDQo+ID4gPj4gIAlkd2MtPmxwbV9ueWV0X3Ro
cmVzaG9sZCA9IGxwbV9ueWV0X3RocmVzaG9sZDsNCj4gPiA+PiAgCWR3Yy0+dHhfZGVfZW1waGFz
aXMgPSB0eF9kZV9lbXBoYXNpczsNCj4gPiA+PiAgDQo+ID4gPj4gQEAgLTIwMjcsMTQgKzIwMzAs
MjAgQEAgc3RhdGljIGludCBkd2MzX3N1c3BlbmRfY29tbW9uKHN0cnVjdCBkd2MzICpkd2MsIHBt
X21lc3NhZ2VfdCBtc2cpDQo+ID4gPj4gIHsNCj4gPiA+PiAgCXVuc2lnbmVkIGxvbmcJZmxhZ3M7
DQo+ID4gPj4gIAl1MzIgcmVnOw0KPiA+ID4+ICsJaW50IHJldDsNCj4gPiA+PiAgDQo+ID4gPj4g
IAlzd2l0Y2ggKGR3Yy0+Y3VycmVudF9kcl9yb2xlKSB7DQo+ID4gPj4gIAljYXNlIERXQzNfR0NU
TF9QUlRDQVBfREVWSUNFOg0KPiA+ID4+ICAJCWlmIChwbV9ydW50aW1lX3N1c3BlbmRlZChkd2Mt
PmRldikpDQo+ID4gPj4gIAkJCWJyZWFrOw0KPiA+ID4+IC0JCWR3YzNfZ2FkZ2V0X3N1c3BlbmQo
ZHdjKTsNCj4gPiA+PiArCQlyZXQgPSBkd2MzX2dhZGdldF9zdXNwZW5kKGR3Yyk7DQo+ID4gPj4g
KwkJaWYgKHJldCkgew0KPiA+ID4+ICsJCQlkZXZfZXJyKGR3Yy0+ZGV2LCAiZ2FkZ2V0IG5vdCBz
dXNwZW5kZWQ6ICVkXG4iLCByZXQpOw0KPiA+ID4+ICsJCQlyZXR1cm4gcmV0Ow0KPiA+ID4+ICsJ
CX0NCj4gPiA+PiAgCQlzeW5jaHJvbml6ZV9pcnEoZHdjLT5pcnFfZ2FkZ2V0KTsNCj4gPiA+PiAt
CQlkd2MzX2NvcmVfZXhpdChkd2MpOw0KPiA+ID4+ICsJCWlmKCFkd2MtPmdhZGdldF9rZWVwX2Nv
bm5lY3Rfc3lzX3NsZWVwKQ0KPiA+ID4+ICsJCQlkd2MzX2NvcmVfZXhpdChkd2MpOw0KPiA+ID4+
ICAJCWJyZWFrOw0KPiA+ID4+ICAJY2FzZSBEV0MzX0dDVExfUFJUQ0FQX0hPU1Q6DQo+ID4gPj4g
IAkJaWYgKCFQTVNHX0lTX0FVVE8obXNnKSAmJiAhZGV2aWNlX21heV93YWtldXAoZHdjLT5kZXYp
KSB7DQo+ID4gPj4gQEAgLTIwODgsMTEgKzIwOTcsMTUgQEAgc3RhdGljIGludCBkd2MzX3Jlc3Vt
ZV9jb21tb24oc3RydWN0IGR3YzMgKmR3YywgcG1fbWVzc2FnZV90IG1zZykNCj4gPiA+PiAgDQo+
ID4gPj4gIAlzd2l0Y2ggKGR3Yy0+Y3VycmVudF9kcl9yb2xlKSB7DQo+ID4gPj4gIAljYXNlIERX
QzNfR0NUTF9QUlRDQVBfREVWSUNFOg0KPiA+ID4+IC0JCXJldCA9IGR3YzNfY29yZV9pbml0X2Zv
cl9yZXN1bWUoZHdjKTsNCj4gPiA+PiAtCQlpZiAocmV0KQ0KPiA+ID4+IC0JCQlyZXR1cm4gcmV0
Ow0KPiA+ID4+ICsJCWlmICghZHdjLT5nYWRnZXRfa2VlcF9jb25uZWN0X3N5c19zbGVlcCkNCj4g
PiA+PiArCQl7DQo+ID4gPj4gKwkJCXJldCA9IGR3YzNfY29yZV9pbml0X2Zvcl9yZXN1bWUoZHdj
KTsNCj4gPiA+PiArCQkJaWYgKHJldCkNCj4gPiA+PiArCQkJCXJldHVybiByZXQ7DQo+ID4gPj4g
Kw0KPiA+ID4+ICsJCQlkd2MzX3NldF9wcnRjYXAoZHdjLCBEV0MzX0dDVExfUFJUQ0FQX0RFVklD
RSk7DQo+ID4gPj4gKwkJfQ0KPiA+ID4+ICANCj4gPiA+PiAtCQlkd2MzX3NldF9wcnRjYXAoZHdj
LCBEV0MzX0dDVExfUFJUQ0FQX0RFVklDRSk7DQo+ID4gPj4gIAkJZHdjM19nYWRnZXRfcmVzdW1l
KGR3Yyk7DQo+ID4gPj4gIAkJYnJlYWs7DQo+ID4gPj4gIAljYXNlIERXQzNfR0NUTF9QUlRDQVBf
SE9TVDoNCj4gPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmggYi9kcml2
ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiA+ID4+IGluZGV4IDU4MmViZDljZjljMi4uZjg0YmFjODE1
YmVkIDEwMDY0NA0KPiA+ID4+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+ID4gPj4g
KysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gPiA+PiBAQCAtMTMyOCw2ICsxMzI4LDgg
QEAgc3RydWN0IGR3YzMgew0KPiA+ID4+ICAJdW5zaWduZWQJCWRpc19zcGxpdF9xdWlyazoxOw0K
PiA+ID4+ICAJdW5zaWduZWQJCWFzeW5jX2NhbGxiYWNrczoxOw0KPiA+ID4+ICANCj4gPiA+PiAr
CXVuc2lnbmVkCQlnYWRnZXRfa2VlcF9jb25uZWN0X3N5c19zbGVlcDoxOw0KPiA+ID4+ICsNCj4g
PiA+PiAgCXUxNgkJCWltb2RfaW50ZXJ2YWw7DQo+ID4gPj4gIA0KPiA+ID4+ICAJaW50CQkJbWF4
X2NmZ19lcHM7DQo+ID4gPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMg
Yi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ID4gPj4gaW5kZXggM2M2M2ZhOTdhNjgwLi44
MDYyZTQ0ZjYzZjYgMTAwNjQ0DQo+ID4gPj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQu
Yw0KPiA+ID4+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gPiA+PiBAQCAtNDU3
MiwxMiArNDU3MiwyMyBAQCB2b2lkIGR3YzNfZ2FkZ2V0X2V4aXQoc3RydWN0IGR3YzMgKmR3YykN
Cj4gPiA+PiAgaW50IGR3YzNfZ2FkZ2V0X3N1c3BlbmQoc3RydWN0IGR3YzMgKmR3YykNCj4gPiA+
PiAgew0KPiA+ID4+ICAJdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gPiA+PiArCWludCBsaW5rX3N0
YXRlOw0KPiA+ID4+ICANCj4gPiA+PiAgCWlmICghZHdjLT5nYWRnZXRfZHJpdmVyKQ0KPiA+ID4+
ICAJCXJldHVybiAwOw0KPiA+ID4+ICANCj4gPiA+PiAtCWR3YzNfZ2FkZ2V0X3J1bl9zdG9wKGR3
YywgZmFsc2UsIGZhbHNlKTsNCj4gPiA+PiArCWlmIChkd2MtPmdhZGdldF9rZWVwX2Nvbm5lY3Rf
c3lzX3NsZWVwICYmIGR3Yy0+Y29ubmVjdGVkKSB7DQo+ID4gPj4gKwkJbGlua19zdGF0ZSA9IGR3
YzNfZ2FkZ2V0X2dldF9saW5rX3N0YXRlKGR3Yyk7DQo+ID4gPj4gKwkJLyogUHJldmVudCBQTSBT
bGVlcCBpZiBub3QgaW4gVTMvTDIgKi8NCj4gPiA+PiArCQlpZiAobGlua19zdGF0ZSAhPSBEV0Mz
X0xJTktfU1RBVEVfVTMpDQo+ID4gPj4gKwkJCXJldHVybiAtRUJVU1k7DQo+ID4gPj4gKw0KPiA+
ID4+ICsJCS8qIGRvbid0IHN0b3AvZGlzY29ubmVjdCAqLw0KPiA+ID4+ICsJCWR3YzNfZ2FkZ2V0
X2Rpc2FibGVfaXJxKGR3Yyk7DQo+ID4gPiANCj4gPiA+IFdlIHNob3VsZG4ndCBkaXNhYmxlIGV2
ZW50IGludGVycnVwdCBoZXJlLiBXaGF0IHdpbGwgaGFwcGVuIGlmIHRoZQ0KPiA+IA0KPiA+IER1
ZSB0byBzb21lIHJlYXNvbiwgaWYgSSBkb24ndCBkaXNhYmxlIHRoZSBldmVudCBpbnRlcnJ1cHRz
IGhlcmUgdGhlbg0KPiA+IGFmdGVyIFVTQiByZXN1bWUgdGhlIFVTQiBjb250cm9sbGVyIGlzIG1h
bGZ1bmN0aW9uaW5nLg0KPiA+IEl0IG5vIGxvbmdlciByZXNwb25kcyB0byBhbnkgcmVxdWVzdHMg
ZnJvbSBIb3N0Lg0KPiANCj4gWW91IHNob3VsZCBsb29rIGludG8gdGhpcy4gVGhlc2UgZXZlbnRz
IGFyZSBpbXBvcnRhbnQgYXMgdGhleSBjYW4gdGVsbA0KPiB3aGV0aGVyIHRoZSBob3N0IGluaXRp
YXRlcyByZXN1bWUuDQo+IA0KPiA+IA0KPiA+ID4gZGV2aWNlIGlzIGRpc2Nvbm5lY3RlZCBhbmQg
cmVjb25uZWN0IHRvIHRoZSBob3N0IHdoaWxlIHRoZSBkZXZpY2UgaXMNCj4gPiA+IHN0aWxsIGlu
IHN5c3RlbSBzdXNwZW5kPyBUaGUgaG9zdCB3b3VsZCBub3QgYmUgYWJsZSB0byBjb21tdW5pY2F0
ZSB3aXRoDQo+ID4gPiB0aGUgZGV2aWNlIHRoZW4uDQo+ID4gDQo+ID4gSW4gdGhlIFRJIHBsYXRm
b3JtLCBUaGUgc3lzdGVtIGlzIHdva2VuIHVwIG9uIGFueSBWQlVTL2xpbmVzdGF0ZSBjaGFuZ2UN
Cj4gPiBhbmQgaW4gZHdjM19nYWRnZXRfcmVzdW1lIHdlIGVuYWJsZSB0aGUgZXZlbnRzIGFnYWlu
IGFuZCBjaGVjayBmb3IgcGVuZGluZw0KPiA+IGV2ZW50cy4gSXMgaXQgcG9pbnRsZXNzIHRvIGNo
ZWNrIGZvciBwZW5kaW5nIGV2ZW50cyB0aGVyZT8NCj4gPiANCj4gDQo+IEl0IHNlZW1zIGZyYWdp
bGUgZm9yIHRoZSBpbXBsZW1lbnRhdGlvbiB0byBiZSBkZXBlbmRlbnQgb24gcGxhdGZvcm0NCj4g
c3BlY2lmaWMgZmVhdHVyZSByaWdodD8NCj4gDQo+IEFsc28sIHdoYXQgd2lsbCBoYXBwZW4gaW4g
YSB0eXBpY2FsIGNhc2Ugd2hlbiB0aGUgaG9zdCBwdXRzIHRoZSBkZXZpY2UNCj4gaW4gc3VzcGVu
ZCBhbmQgaW5pdGlhdGVzIHJlc3VtZSB3aGlsZSB0aGUgZGV2aWNlIGlzIGluIHN5c3RlbSBzdXNw
ZW5kDQo+IChhbmQgc3RheSBpbiBzdXNwZW5kIG92ZXIgYSBwZXJpb2Qgb2YgdGltZSk/IFRoZXJl
IGlzIG5vIFZCVVMgY2hhbmdlLg0KPiBUaGVyZSB3aWxsIGJlIHByb2JsZW0gaWYgaG9zdCBkZXRl
Y3RzIG5vIHJlc3BvbnNlIGZyb20gZGV2aWNlIGluIHRpbWUuDQo+IA0KPiBEb24ndCB3ZSBuZWVk
IHRoZXNlIGV2ZW50cyB0byB3YWtldXAgdGhlIGRldmljZT8NCj4gDQoNCldlIG1heSBub3QgYmUg
YWJsZSB0byBzdXNwZW5kIGV2ZXJ5dGhpbmcgaW4gc3lzdGVtIHN1c3BlbmQgZm9yIHRoaXMNCmNh
c2UuIEknbSB0aGlua2luZyBvZiB0cmVhdGluZyB0aGVzZSBldmVudHMgYXMgaWYgdGhleSBhcmUg
UE1FIHRvIHdha2V1cA0KdGhlIGRldmljZSwgYnV0IHRoZXkgYXJlIG5vdCB0aGUgc2FtZS4gSXQg
bWF5IG5vdCBiZSBzaW1wbGUgdG8gaGFuZGxlDQp0aGlzLiBUaGUgbG93ZXIgbGF5ZXJzIG1heSBu
ZWVkIHRvIHN0YXkgYXdha2UgZm9yIHRoZSBkd2MzIHRvIGhhbmRsZQ0KdGhlc2UgZXZlbnRzLiBI
bS4uLiBpdCBnZXRzIGEgYml0IGNvbXBsaWNhdGVkLg0KDQpUaGFua3MsDQpUaGluaA==
