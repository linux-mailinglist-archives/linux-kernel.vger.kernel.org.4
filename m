Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A14B672EE4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 03:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjASCTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 21:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjASCS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 21:18:57 -0500
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0BB4AA74;
        Wed, 18 Jan 2023 18:18:56 -0800 (PST)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30INIYuU004900;
        Wed, 18 Jan 2023 18:18:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=WKtd1eGkiADaBlNJ9O3GX7Zj2fkV20+m9v2AFZNafE8=;
 b=E24N27yu0ff9skjayhtG+q2x10OHJTix6bkT2X1V/8Le8U7ikh3ZkzfAR+GipX9i5LAv
 if40EQHf/GmFRUm7OBxOxjqyrz9PLIMVxe9bCNo8X1K8GQDI9bnKVbZ8RwQI5jjENLHn
 CMJ3Rev0JRNZzWw25Cni3lxlbJ28oceVSnUgfRHFCror8zU3Ob/k+RvdLJaQhh8VR6vJ
 B3NF3niwxGAU8FZvs4NG1/LksMQ6XdYfcxKkpuu2XAXm5XnqqrJYCX04ifb02zFZydzU
 CSdUiQTcR+mWsZd/J94iOK+AN20XpJtP0nGxGGCgOpKq/0bILC5K/p9gKnCUKD1Rp1bL bA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3n3uwmhvuw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 18:18:49 -0800
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E3AA6C2325;
        Thu, 19 Jan 2023 02:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1674094728; bh=WKtd1eGkiADaBlNJ9O3GX7Zj2fkV20+m9v2AFZNafE8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=VSJxkY3KS9ZlMqdumYP7ibSxsJgPCubsHXJVpvMt64lHnRXQ2QDDQl+hEftbndIsB
         pE+FJoylFHfltZOhhBqdhyzOEYYtaFh3jn5PmZTBnS7pzynNnFU/p9n1YJsy0ewfKk
         1ChlKQFZjPiJiwvkXUF1DiHbKzwpc9bdmxvZu2uh+lXtp2uf4GNyXcWvjab99SxBEM
         F8KmeDHSLt4RwJT+WUW1qzlKCh8nsU85AWqw1abXJXu5y+n5U90pHic0lE5wVwv7RE
         9uUJvYy7ACfLWyXPPw2IsFOkJ8LdPHEuxQTLuiIiXM+WQDlhGoSXlw8UMOJ1gD4duy
         wAteV3kyZrF0A==
Received: from o365relay-in.synopsys.com (sv2-o365relay5.synopsys.com [10.202.1.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 65A2FA006C;
        Thu, 19 Jan 2023 02:18:46 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 4D73AA008B;
        Thu, 19 Jan 2023 02:18:46 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="jFVaxCuA";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3CftOe1Gb2+PrsqFjZ/NQrqiyXLysGtvOwsJZ8Zhgx6RF97UZXhUB1VCyJT/uh9bwp9rKgz65M3aDw/w3Kmosl5LATwtYk7m5pQbwVzyi212tAmdsxdAapWynmqkxLwSGZhvjGlG99cbxGiDOQHX2IIv6aByr2lS/X41jP/fvXFMvpzOWJ3oIcyFk0gAk12DpuF2ohzTeT5RW46aQ8pJ4HxCSW2BaAT2PU7hIUQg95opsPUm9sJP11FtKx1jaOqURaEmy3o5tBnB1gsDPvpdh2yOLz6PFEk7E9lzRHv7o+6vFgHrfOH98oEvm2HajuZaajcPjn2qSpYUYd140bgMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKtd1eGkiADaBlNJ9O3GX7Zj2fkV20+m9v2AFZNafE8=;
 b=oYcR47IOjF2tQOnPe+V2QMOMjx1Jlc+gsBTZXnJpJslQFp8HJWbdf3x2vgecnVNa+NBMJW98SaE24W87WSv2KmbLLNNg2S+Q8mxsYSHOTv8tTWbTMrtZLg0x19aAIzDvskR9pQ7L6xspPbX2hRH8KBxXc6I4kqJ3pCtNJjuAFhtfdSl1PL1d2lovv6+rnMEK9LGxRWx5HayP2N8h3DjnRZQMtM6d5Cv6m0hTYcKN4nnJO4+5/8fwuhzZ6aY2S5Lv46DowG7dk6fudypnPrq3E5AaK2hX3h/sEul0mi14m0qOOzVi0XJ11FCx/hlB0kSf5I7maWLZfdJr83ausSA7Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKtd1eGkiADaBlNJ9O3GX7Zj2fkV20+m9v2AFZNafE8=;
 b=jFVaxCuATyCHeyvfKUASYjg1rd8JCzdy72zXp19n4l2xUuCXUmvToalc89LWZUdTB2lJkAq/HY8+MOCIXToET/KY8HJXQTeGFfcBB2rOQsVb/dZan8cnTh6G5Vx+2jrvLt7lYdfD/EPUIW4EW302sRwaJTGZlLpImW/ljskBBtY=
Received: from BN8PR12MB4787.namprd12.prod.outlook.com (2603:10b6:408:a1::11)
 by PH0PR12MB8030.namprd12.prod.outlook.com (2603:10b6:510:28d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 02:18:43 +0000
Received: from BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::d065:4646:c9d2:9219]) by BN8PR12MB4787.namprd12.prod.outlook.com
 ([fe80::d065:4646:c9d2:9219%7]) with mapi id 15.20.5986.021; Thu, 19 Jan 2023
 02:18:43 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Elson Roy Serrao <quic_eserrao@quicinc.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v2 4/5] usb: dwc3: Add function suspend and function
 wakeup support
Thread-Topic: [PATCH v2 4/5] usb: dwc3: Add function suspend and function
 wakeup support
Thread-Index: AQHZKr5maNmInVxiX0GOMrf70GT5qK6lAzEA
Date:   Thu, 19 Jan 2023 02:18:42 +0000
Message-ID: <20230119021838.luuiwe5n6npf3kaj@synopsys.com>
References: <1673992507-7823-1-git-send-email-quic_eserrao@quicinc.com>
 <1673992507-7823-5-git-send-email-quic_eserrao@quicinc.com>
In-Reply-To: <1673992507-7823-5-git-send-email-quic_eserrao@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR12MB4787:EE_|PH0PR12MB8030:EE_
x-ms-office365-filtering-correlation-id: cc32daca-e469-499e-07ed-08daf9c37c68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QLnhK5ahROQ7gNNq6ZKBtssq6oNwZ9delhKsmTlbM/QbxIt+Fd4VrKF1iija4SnrKsu1W14z57QZB/GrjGY0vtKS+z0IdO/sdx0eStvNYoTpfv0ZPQNr9PA43EPCXIc0m8wkpFlHRGXhqpPMilYhNyrfHTiVnCoecFvWKi1wY/bUAsIBfdKQkA0naEAim1PRSKa/G4USqVqF9qPo4c8efxpImgyMuSaMwSnEPDmMxocpXVZl+LBzoqPHQxPdrwcJZJJb07AM3nPgIdQp21V+eC3Pv58xJZecsfMpgxSe5FVb5PvwCdYMDu7kwlyJgpj8CwOCb705+Qib+EOxxh/I4BHP592tYXEBAwwqtqzdGBZczwwN1Tl7Ql2vxeux7bO9biKcJ60v0ypfkcv+852TSneCkKM9mkNIBBFv9iNQObTvjNDyyjvp84ttLw4VEH1S5WiQG0OqTGBnDkKarO1JGV6cQO5AqaQeE09/m4BsHwXUVkf37Xw5fVH0WkCygx1bO/NNY7YiSr/ZkcPC6WaSgWGgVN3moia8zRx2mxikS70v1v34Npv03DSH/+VBBh2oDnwukGeOrlD2HUfTs5wMpJhCx764XGgS8LpTo6v/lxi9moQ/grLJqPwFzX/FJF4vovJTL+juaIZjeNxwDck4qckHanFyUYaXx5EsHYKLDDiPD83ckOsBP6+zheF4yCNh6JyXUvuUF9OXSp2v+skBBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB4787.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199015)(2616005)(38100700002)(122000001)(54906003)(186003)(1076003)(26005)(6512007)(71200400001)(478600001)(86362001)(6486002)(38070700005)(36756003)(66899015)(83380400001)(6506007)(41300700001)(91956017)(5660300002)(8936002)(6916009)(8676002)(66556008)(66476007)(4326008)(76116006)(66946007)(64756008)(15650500001)(2906002)(316002)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzI1UU5zZkdZY3NLQUNpZU9IelRMaDBxOVpXWlVXaXhRU3Yzd0l6YnB5QlNx?=
 =?utf-8?B?MlpRS1BDUmRVZ2JXNnNiaHNwNno2QTUzOEJCYUZaeXNnZ0JONVQ5OFZqYmVE?=
 =?utf-8?B?WC94MG8vN2RBcGwzR2FkK1oyZ1hDWWFzOFA2cFBGMTZyZjVIYk04dGIwRjNw?=
 =?utf-8?B?WkhlL3Y1YzVUSExmbHRPeXp5OXJNRzBXeWMxaXo1eEhkOUlGa0NjcjV1NTVt?=
 =?utf-8?B?dDZyU1dDTytxV2N6Um9XeWxTSFp3dHVDVlBKWUozVnE0UW1iT2xNOGJPRnlP?=
 =?utf-8?B?dGo0QTAwMlRIWGJZdWhWYktDTzdLaEJ2VzBQRWEwVEo1SXlGVnE0V3BXK25j?=
 =?utf-8?B?TFF4MlpDRFNkWkNZSko3TUVMQWtsVVhYb2ZSZGlDYXJqdmNpd2VPZlhycmpE?=
 =?utf-8?B?QU9XNS9IMGtETmVpMDYvUkVBTGVFQ1Jtd2xCVlR0L0NST25ETWNhb016QkVx?=
 =?utf-8?B?R0N1VXlRT05GakF0TEs5TllBTEU2RUZGTjA0dnJqUTEzbDVtbzdNb1ZvRUY3?=
 =?utf-8?B?eHFyMUFld1pYbTlGUUdGWVY0eHZvQy81YWM4UDl0K25iK3JNeElLQ0gybkwx?=
 =?utf-8?B?RG4vRi9Ya0k1RHczazgwcnJZVzMySERsMTAwaXBIdnYwNSsvY0I4VTVRaVJy?=
 =?utf-8?B?V0FuUTBTOWJWSE1zblFGVUJORk9Ka3I4UEtTdGtDbWl0cGd0VEJQejhlRGRu?=
 =?utf-8?B?TkM2Nlg4RWdZRWVrM0tXa3lsa0lpd3hDMEdBUG9KUkF3NEpBU3lBdnBBN2w3?=
 =?utf-8?B?cnNMMEh5Z1k2ZDVWK3FUSm9mdnM1R3c2WDg2bnNzUEt3NDlDOSsraU1oZ0xo?=
 =?utf-8?B?cVQ2Ym1NVUM0ZXo5V0ZSeVFkd0d0RXVEWngzRjRNOG01ZlRJYXc5d1pnMGNy?=
 =?utf-8?B?OTNoaWZFNDBYU1BSRGNISTJCdWxoYmN5cFdnVGJnSVYrRVFORVdGQ1UxTFVQ?=
 =?utf-8?B?MU8yYWNxTFlMbEhIQWpaUEExMmlzRFJjM2hTbWhNdy9wTGUyQkZQeGt1OEdk?=
 =?utf-8?B?QTZXc201SE81WTMyeXhMZTl3OG1obGRuQVRxeDBnK3pXWVI5dkxnSWlpQytz?=
 =?utf-8?B?dGV0VnRJRUh0QUFBWlRmbXB5VHR6QlpxNzlCYTh2Rmg0SXRSZHR2RzVLcVF4?=
 =?utf-8?B?ZFFHcXc5NWYrZUpCeEU1QXJVNGJKRzBIdWxZeDVkcG5SdDFLTzlDRXZBTUpj?=
 =?utf-8?B?RFZjVDF5STVWVnVzaHRIbjhPb2pNNUcrR1d3UDNZeW5PMjFnNU4ycGx4QmF0?=
 =?utf-8?B?R0tjODViM2RaRUc2cFJTKy9jdWRZWklJdldsY04yWXV5djFMT2dMbVFMREZW?=
 =?utf-8?B?bjlnZjRKNi9wUjFSY1pld3J3ZkYxcTUvUGRpUFpZcWwxMG5CR09zT0dKVWdK?=
 =?utf-8?B?WGhzN3pUTEZlc2dRUDM0bDRIU21kNDB5ZFM0N0dFVUV5RkE1NjFsc3hLai9T?=
 =?utf-8?B?MFBYRVp6ZHhkR2VWdzRKSUNEaWNRRDZ5UlBJbjBTNDJFT09lR3BweHV6Lzk4?=
 =?utf-8?B?YVB5dkdETGhneXFqYjZWUC9pTnBqM2FmNWZxanNKNnV2ZXpFVDdxZVVwK1I3?=
 =?utf-8?B?YWlNakhiYVJWS0JTaGtNVXEzeDFOTmFjOGZGc0YwanYyMmlabmJxZ2oyRUl3?=
 =?utf-8?B?dFFidHNVS3BLVnVmeWlBTy91OXlXdW1VK1M1cXNSUXlnRVJJOXBwcVRaeVgy?=
 =?utf-8?B?bFdjK2QzWVpVV0x0dDN0WGltM0FxSzV1d2dIWWNHNmRRdCtVelp3SXl2U09m?=
 =?utf-8?B?MUNHZ1JOMHl3aytFMmZpTGxWN0c4T3c4OWZMZWdKOFZla2JnRHZnLzBOanNS?=
 =?utf-8?B?N2xBYm9QTTZqWVpqVjYzNytUTDR0bElFbnRlZ1J2b21POGpqVjh3Sm1hU05j?=
 =?utf-8?B?OXNRKzlldlZWc0FMKzliT1dNQVpIay9SZjhBWDBaRjRVbXI3SnRBcTlnS2Iv?=
 =?utf-8?B?OWl1UkFScEZFdWNQQVp0c1kwU0lYZmpKcmN2dkNnWGNHWUt4NXo3YVhscGM0?=
 =?utf-8?B?T0N0eGswZjRYb3JTcTQ4T2lEVnlHYmkvbmJHME5BemVmZ3YrbGV1U1BORGhU?=
 =?utf-8?B?NjlqU0I5b3NoOW9iVE51YkoydWNlbFFWR0daTWNOOUJHYkdRMi80QjhtM0s3?=
 =?utf-8?B?M3pVaXVWV1RvSTZtRUh0Ry9TTGNmQzNjNEJjWW5HaU92SHNUbVdqZTBodkNE?=
 =?utf-8?B?THc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E123BDF240497D4284F88AE1C3B53552@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1xkBWZ5MOdY3NaLpI8IuG7lMYrt6FXnuPl3Of0iBIIafw63afPY5O4A8p0xQ/JZbjnIYaEnuPr70nW96YpufyVc9UFMvwu1d37GWTed1YOaS52gJarGPvDxT6isL4Q2QWRacPYvHHWdNeyLbjmoKue/pO1DJL4X9ZUjc3yksV0Hj0jffzOwoWvcObeRZDFyxd3Rn//XW3yr7ufMzMpq4Cgv3QoyvAyudFIgJHNyV3TMzkiwyXFHtUrYhIYrkenWJhEtaT98ns3zUezDri2hAGw6FXEDxODPAw9NGO7XElEf0OHihDhmTD4VL8/vgjvpwFcrcrG1KU77skm7yAWajZFD1LDQxtOsZf8zFGkmmAH5V1ZBR3PiBOxg9IjqjQGK8vbmqpUfBuhJqa9cNudwrVUiyHObEL03WiAJf6zNgMG6U39JU3ZdGl0MJkH0Aj4XDAF4gDjI7E1qYsMerVMupI8z12Eif0atdLEuwPrqmcgPtz6kdaNIjPlxiSbFfGqV9xAXtplC/v1qzxJaW4Lf8/16SbxqSaW7DFNeBgeFWNNhkkQmW5UgRk+098gnhmr+sJTIylp60RFqoVzeqmfR7MqEbfUsrJ9hRnXiTGf3isu9xNKvK7u3QXyOtV4qZwJBCPp1Z+KPziP0K988yHHEzoMBm9Niy2Udt3qADq2FSNDjY5o0JEVDvymcM963oIf3kwnmpmdCxql4cJ74bgPzTZWPp/FxTy7uueB6AIqLTv/jlj/gkXfakEkTeqX+nyZ2dXHrk+cuYBZUmQgX8ywN/OW+8rISu8QmUweviwF8QD2jeEOJXq0MIxZbJgYc9LoSTcZtDA4RBB3WPrhTKksicZdvTH9OxJvVsDnmKMVr08/CXWhAQ0z3h5CkcyO1Lzd9kz5TYqa6MY9AxDlddMk1Zoh0Ppdu6g8PTjc7LD5uyc0I=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB4787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc32daca-e469-499e-07ed-08daf9c37c68
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2023 02:18:42.7165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TlKriYSeEEqRmr521dGGXUuEJm4UZXW4svjEyJxRcPlZs6LbcU1fm0TBsUiKnGzUPlcLXP073A/X1gm8sxsnIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8030
X-Proofpoint-ORIG-GUID: 56hRw16p099-MJ5_TRLNR5oymyUWgHfq
X-Proofpoint-GUID: 56hRw16p099-MJ5_TRLNR5oymyUWgHfq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 spamscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301190013
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBKYW4gMTcsIDIwMjMsIEVsc29uIFJveSBTZXJyYW8gd3JvdGU6DQo+IFVTQiBob3N0
IHNlbmRzIGZ1bmN0aW9uIHN1c3BlbmQgYW5kIGZ1bmN0aW9uIHJlc3VtZSBub3RpZmljYXRpb25z
IHRvDQo+IHRoZSBpbnRlcmZhY2UgdGhyb3VnaCBTRVRfRkVBVFVSRS9DTEVBUl9GRUFUVVJFIHNl
dHVwIHBhY2tldHMuDQo+IEFkZCBzdXBwb3J0IHRvIGhhbmRsZSB0aGVzZSBwYWNrZXRzIGJ5IGRl
bGVnYXRpbmcgdGhlIHJlcXVlc3RzIHRvDQo+IGNvbXBvc2l0ZSBsYXllci4gQWxzbyBhZGQgc3Vw
cG9ydCB0byBoYW5kbGUgZnVuY3Rpb24gd2FrZSBub3RpZmljYXRpb24NCj4gcmVxdWVzdHMgdG8g
ZXhpdCBmcm9tIGZ1bmN0aW9uIHN1c3BlbmQgc3RhdGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBF
bHNvbiBSb3kgU2VycmFvIDxxdWljX2VzZXJyYW9AcXVpY2luYy5jb20+DQo+IC0tLQ0KPiAgZHJp
dmVycy91c2IvZHdjMy9jb3JlLmggICB8ICAxICsNCj4gIGRyaXZlcnMvdXNiL2R3YzMvZGVidWcu
aCAgfCAgMiArKw0KPiAgZHJpdmVycy91c2IvZHdjMy9lcDAuYyAgICB8IDEyICsrKystLS0tLS0t
LQ0KPiAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyB8IDM2ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrLQ0KPiAgNCBmaWxlcyBjaGFuZ2VkLCA0MiBpbnNlcnRpb25zKCspLCA5
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5o
IGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gaW5kZXggNTNkZWQwOC4uNWNkYTY0NSAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gKysrIGIvZHJpdmVycy91c2Iv
ZHdjMy9jb3JlLmgNCj4gQEAgLTUyNiw2ICs1MjYsNyBAQA0KPiAgI2RlZmluZSBEV0MzX0RHQ01E
X1NFVF9FTkRQT0lOVF9OUkRZCTB4MGMNCj4gICNkZWZpbmUgRFdDM19ER0NNRF9TRVRfRU5EUE9J
TlRfUFJJTUUJMHgwZA0KPiAgI2RlZmluZSBEV0MzX0RHQ01EX1JVTl9TT0NfQlVTX0xPT1BCQUNL
CTB4MTANCj4gKyNkZWZpbmUgRFdDM19ER0NNRF9ERVZfTk9USUZJQ0FUSU9OCTB4MDcNCj4gIA0K
PiAgI2RlZmluZSBEV0MzX0RHQ01EX1NUQVRVUyhuKQkJKCgobikgPj4gMTIpICYgMHgwRikNCj4g
ICNkZWZpbmUgRFdDM19ER0NNRF9DTURBQ1QJCUJJVCgxMCkNCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdXNiL2R3YzMvZGVidWcuaCBiL2RyaXZlcnMvdXNiL2R3YzMvZGVidWcuaA0KPiBpbmRleCA0
OGI0NGI4Li4wODk3ZDlkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2RlYnVnLmgN
Cj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9kZWJ1Zy5oDQo+IEBAIC03Miw2ICs3Miw4IEBAIGR3
YzNfZ2FkZ2V0X2dlbmVyaWNfY21kX3N0cmluZyh1OCBjbWQpDQo+ICAJCXJldHVybiAiU2V0IEVu
ZHBvaW50IFByaW1lIjsNCj4gIAljYXNlIERXQzNfREdDTURfUlVOX1NPQ19CVVNfTE9PUEJBQ0s6
DQo+ICAJCXJldHVybiAiUnVuIFNvQyBCdXMgTG9vcGJhY2sgVGVzdCI7DQo+ICsJY2FzZSBEV0Mz
X0RHQ01EX0RFVl9OT1RJRklDQVRJT046DQo+ICsJCXJldHVybiAiRGV2aWNlIE5vdGlmaWNhdGlv
biI7DQo+ICAJZGVmYXVsdDoNCj4gIAkJcmV0dXJuICJVTktOT1dOIjsNCj4gIAl9DQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2VwMC5jIGIvZHJpdmVycy91c2IvZHdjMy9lcDAuYw0K
PiBpbmRleCAwYzEyMDNkLi5lMDVjMmI5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2Mz
L2VwMC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZXAwLmMNCj4gQEAgLTMwLDYgKzMwLDgg
QEANCj4gIHN0YXRpYyB2b2lkIF9fZHdjM19lcDBfZG9fY29udHJvbF9zdGF0dXMoc3RydWN0IGR3
YzMgKmR3Yywgc3RydWN0IGR3YzNfZXAgKmRlcCk7DQo+ICBzdGF0aWMgdm9pZCBfX2R3YzNfZXAw
X2RvX2NvbnRyb2xfZGF0YShzdHJ1Y3QgZHdjMyAqZHdjLA0KPiAgCQlzdHJ1Y3QgZHdjM19lcCAq
ZGVwLCBzdHJ1Y3QgZHdjM19yZXF1ZXN0ICpyZXEpOw0KPiArc3RhdGljIGludCBkd2MzX2VwMF9k
ZWxlZ2F0ZV9yZXEoc3RydWN0IGR3YzMgKmR3YywNCj4gKwkJCQkgc3RydWN0IHVzYl9jdHJscmVx
dWVzdCAqY3RybCk7DQo+ICANCj4gIHN0YXRpYyB2b2lkIGR3YzNfZXAwX3ByZXBhcmVfb25lX3Ry
YihzdHJ1Y3QgZHdjM19lcCAqZGVwLA0KPiAgCQlkbWFfYWRkcl90IGJ1Zl9kbWEsIHUzMiBsZW4s
IHUzMiB0eXBlLCBib29sIGNoYWluKQ0KPiBAQCAtMzY3LDcgKzM2OSw3IEBAIHN0YXRpYyBpbnQg
ZHdjM19lcDBfaGFuZGxlX3N0YXR1cyhzdHJ1Y3QgZHdjMyAqZHdjLA0KPiAgCQkgKiBGdW5jdGlv
biBSZW1vdGUgV2FrZSBDYXBhYmxlCUQwDQo+ICAJCSAqIEZ1bmN0aW9uIFJlbW90ZSBXYWtldXAJ
RDENCj4gIAkJICovDQo+IC0JCWJyZWFrOw0KPiArCQlyZXR1cm4gZHdjM19lcDBfZGVsZWdhdGVf
cmVxKGR3YywgY3RybCk7DQo+ICANCj4gIAljYXNlIFVTQl9SRUNJUF9FTkRQT0lOVDoNCj4gIAkJ
ZGVwID0gZHdjM193SW5kZXhfdG9fZGVwKGR3YywgY3RybC0+d0luZGV4KTsNCj4gQEAgLTUxNCwx
MyArNTE2LDcgQEAgc3RhdGljIGludCBkd2MzX2VwMF9oYW5kbGVfaW50ZihzdHJ1Y3QgZHdjMyAq
ZHdjLA0KPiAgDQo+ICAJc3dpdGNoICh3VmFsdWUpIHsNCj4gIAljYXNlIFVTQl9JTlRSRl9GVU5D
X1NVU1BFTkQ6DQo+IC0JCS8qDQo+IC0JCSAqIFJFVklTSVQ6IElkZWFsbHkgd2Ugd291bGQgZW5h
YmxlIHNvbWUgbG93IHBvd2VyIG1vZGUgaGVyZSwNCj4gLQkJICogaG93ZXZlciBpdCdzIHVuY2xl
YXIgd2hhdCB3ZSBzaG91bGQgYmUgZG9pbmcgaGVyZS4NCj4gLQkJICoNCj4gLQkJICogRm9yIG5v
dywgd2UncmUgbm90IGRvaW5nIGFueXRoaW5nLCBqdXN0IG1ha2luZyBzdXJlIHdlIHJldHVybg0K
PiAtCQkgKiAwIHNvIFVTQiBDb21tYW5kIFZlcmlmaWVyIHRlc3RzIHBhc3Mgd2l0aG91dCBhbnkg
ZXJyb3JzLg0KPiAtCQkgKi8NCj4gKwkJcmV0ID0gZHdjM19lcDBfZGVsZWdhdGVfcmVxKGR3Yywg
Y3RybCk7DQo+ICAJCWJyZWFrOw0KPiAgCWRlZmF1bHQ6DQo+ICAJCXJldCA9IC1FSU5WQUw7DQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdj
My9nYWRnZXQuYw0KPiBpbmRleCBkYjRiNDM4Li4xYzk1OGM0IDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMN
Cj4gQEAgLTIzNDYsNyArMjM0Niw3IEBAIHN0YXRpYyBpbnQgX19kd2MzX2dhZGdldF93YWtldXAo
c3RydWN0IGR3YzMgKmR3YywgYm9vbCBhc3luYykNCj4gIAkJcmV0dXJuIDA7DQo+ICANCj4gIAkv
KiBwb2xsIHVudGlsIExpbmsgU3RhdGUgY2hhbmdlcyB0byBPTiAqLw0KPiAtCXJldHJpZXMgPSAy
MDAwMDsNCj4gKwlyZXRyaWVzID0gMzAwMDA7DQoNClRoaXMgc2VlbXMgbGlrZSBhIGZpeCB0aGF0
IG5lZWRzIHRvIGJlIHNwbGl0dGVkIHRvIGEgc2VwYXJhdGUgY2hhbmdlLg0KcmVhZF9wb2xsX3Rp
bWVvdXRfYXRvbWljKCkgd291bGQgYmUgdXNlZnVsIGhlcmUgKGFzIGEgc2VwYXJhdGUvdW5yZWxh
dGVkDQpjaGFuZ2UgZm9yIHN0YXR1cyBwb2xsaW5nKS4NCg0KPiAgDQo+ICAJd2hpbGUgKHJldHJp
ZXMtLSkgew0KPiAgCQlyZWcgPSBkd2MzX3JlYWRsKGR3Yy0+cmVncywgRFdDM19EU1RTKTsNCj4g
QEAgLTIzODMsNiArMjM4MywzOSBAQCBzdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X3dha2V1cChzdHJ1
Y3QgdXNiX2dhZGdldCAqZykNCj4gIAlyZXR1cm4gcmV0Ow0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMg
dm9pZCBkd2MzX3Jlc3VtZV9nYWRnZXQoc3RydWN0IGR3YzMgKmR3Yyk7DQo+ICsNCj4gK3N0YXRp
YyBpbnQgZHdjM19nYWRnZXRfZnVuY193YWtldXAoc3RydWN0IHVzYl9nYWRnZXQgKmcsIGludCBp
bnRlcmZhY2VfaWQpDQo+ICt7DQo+ICsJc3RydWN0ICBkd2MzCQkqZHdjID0gZ2FkZ2V0X3RvX2R3
YyhnKTsNCj4gKwl1bnNpZ25lZCBsb25nCQlmbGFnczsNCj4gKwlpbnQJCQlyZXQ7DQo+ICsNCj4g
KwlzcGluX2xvY2tfaXJxc2F2ZSgmZHdjLT5sb2NrLCBmbGFncyk7DQo+ICsJLyoNCj4gKwkgKiBJ
ZiB0aGUgbGluayBpcyBpbiBMUE0sIGZpcnN0IGJyaW5nIHRoZSBsaW5rIHRvIFUwDQoNClJld29y
ZCBMTVAgLT4gbG93IHBvd2VyLg0KDQo+ICsJICogYmVmb3JlIHRyaWdnZXJpbmcgZnVuY3Rpb24g
cmVtb3RlIHdha2V1cC4NCj4gKwkgKi8NCj4gKwlpZiAoZHdjLT5saW5rX3N0YXRlID09IERXQzNf
TElOS19TVEFURV9VMykgew0KPiArCQlyZXQgPSBfX2R3YzNfZ2FkZ2V0X3dha2V1cChkd2MsIGZh
bHNlKTsNCj4gKwkJaWYgKHJldCkgew0KPiArCQkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZHdj
LT5sb2NrLCBmbGFncyk7DQo+ICsJCQlyZXR1cm4gLUVJTlZBTDsNCj4gKwkJfQ0KPiArCQlkd2Mz
X3Jlc3VtZV9nYWRnZXQoZHdjKTsNCj4gKwkJZHdjLT5saW5rX3N0YXRlID0gRFdDM19MSU5LX1NU
QVRFX1UwOw0KPiArCX0NCj4gKw0KPiArCXJldCA9IGR3YzNfc2VuZF9nYWRnZXRfZ2VuZXJpY19j
b21tYW5kKGR3YywgRFdDM19ER0NNRF9ERVZfTk9USUZJQ0FUSU9OLA0KPiArCQkJCQkgICAgICAg
MHgxIHwgKGludGVyZmFjZV9pZCA8PCA0KSk7DQoNCkNyZWF0ZSBhIG1hY3JvIGZvciAweDEuIFNv
bWV0aGluZyBsaWtlIERXQzNfREdDTURQQVJfRE5fRlVOQ19XQUtFLiBBbHNvLA0KY3JlYXRlIGFu
IG1hY3JvIGZvciBpbnRlcmZhY2Ugc2VsZWN0aW9uLiBNYXliZQ0KRFdDM19ER0NNRFBBUl9JTlRG
X1NFTChpbnRlcmZhY2VfaWQpLg0KDQo+ICsJaWYgKHJldCkNCj4gKwkJZGV2X2Vycihkd2MtPmRl
diwgImZ1bmN0aW9uIHJlbW90ZSB3YWtldXAgZmFpbGVkLCByZXQ6JWRcbiIsIHJldCk7DQo+ICsN
Cj4gKwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4gKw0KPiAr
CXJldHVybiByZXQ7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBpbnQgZHdjM19nYWRnZXRfc2V0X3Nl
bGZwb3dlcmVkKHN0cnVjdCB1c2JfZ2FkZ2V0ICpnLA0KPiAgCQlpbnQgaXNfc2VsZnBvd2VyZWQp
DQo+ICB7DQo+IEBAIC0zMDEyLDYgKzMwNDUsNyBAQCBzdGF0aWMgdm9pZCBkd2MzX2dhZGdldF9h
c3luY19jYWxsYmFja3Moc3RydWN0IHVzYl9nYWRnZXQgKmcsIGJvb2wgZW5hYmxlKQ0KPiAgc3Rh
dGljIGNvbnN0IHN0cnVjdCB1c2JfZ2FkZ2V0X29wcyBkd2MzX2dhZGdldF9vcHMgPSB7DQo+ICAJ
LmdldF9mcmFtZQkJPSBkd2MzX2dhZGdldF9nZXRfZnJhbWUsDQo+ICAJLndha2V1cAkJCT0gZHdj
M19nYWRnZXRfd2FrZXVwLA0KPiArCS5mdW5jX3dha2V1cAkJPSBkd2MzX2dhZGdldF9mdW5jX3dh
a2V1cCwNCj4gIAkuc2V0X3NlbGZwb3dlcmVkCT0gZHdjM19nYWRnZXRfc2V0X3NlbGZwb3dlcmVk
LA0KPiAgCS5wdWxsdXAJCQk9IGR3YzNfZ2FkZ2V0X3B1bGx1cCwNCj4gIAkudWRjX3N0YXJ0CQk9
IGR3YzNfZ2FkZ2V0X3N0YXJ0LA0KPiAtLSANCj4gMi43LjQNCj4gDQoNClRoYW5rcywNClRoaW5o
