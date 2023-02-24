Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2614C6A21A8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 19:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjBXSi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 13:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBXSi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 13:38:57 -0500
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E95EC79;
        Fri, 24 Feb 2023 10:38:42 -0800 (PST)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OHIvYP020733;
        Fri, 24 Feb 2023 10:38:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=tbq4pYJO9EMQMQQX6qFehs++CyG/2fe2pujODc0yDEI=;
 b=I3Pt4RjOfTvLNUXVUSItyN4Qxg+z9VabFUq3uBijGCgAFswhsuamr3E8706B64goeSWB
 YHOVt3Ahge+5i8HpENjpSblabJBc4NXRkJTmc6st8iakcUWtXMZCEG6J550Es2VlXoUf
 /Gzy6pO1JL7axXIiqXH9beteKMd0RMdexVyWH6I4eEmR5M9rPnvp7/ZINxXKLCrSCgSo
 KrGAcoc6j1/4wZDfBE/pStACge38HGiQz3naTz3f/D8xStha6U+yhJyFR00YVvfuo7gv
 hMHrMXDrsHV4KoMofGijx0uc8L+yHGLb9b9pDOjxm13OjU0QJ9C4qqkUlBDSylqLgUV4 Bw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3nwy6mgjbh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 10:38:37 -0800
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 66195400BA;
        Fri, 24 Feb 2023 18:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1677263916; bh=tbq4pYJO9EMQMQQX6qFehs++CyG/2fe2pujODc0yDEI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=fdXZMEe13hL8qXCF+5j4PJi0PnYQSJ1kcVv7Sm7ezPKC9k8ee8asYOBZ0yzsKMGC3
         ScfSO7OrpGTA/PRF0U0B8ONneM9gK1E59pYGogni9PTAR+AKRR18x8283dCDopfsjN
         +51ZZ9owWb+YsR2W+B7p/Li3ccHGvvwCcVYGaIdlbxOdDuub5VjdOjaNmaioDxKeA5
         tRa+duWYPlB6JIjMzW/g0rcci7DJthc3f3Q2HEHEXEIIguzj5q6tm3blLJbMzmskqT
         H8GfcbYPkSAy53sETfrJLJjd9atizALaviDgUMrlgIfvtnubaYcPW059n0doGzKm45
         Ylhk8VwnvfhRg==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id BF572A0060;
        Fri, 24 Feb 2023 18:38:35 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id C7EAC800F6;
        Fri, 24 Feb 2023 18:38:34 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="LCiiLBeV";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXbjHdP1Pee9ET6sxLs6yIfkDLXLiFVkEn2IQ2nl+cbbEmlIDPeSAVT3U6d0qpoprk9EddssTDjBF0CGqdnT0R//rgJQQJrg9NJyQwcgMf+qMvvHJ5DyRy5kyJk3ADAzAFqU+10Qp5yZTgSAwjbHA8rfiSfcTLv0dPEVbImIsCmopOcF8eSz8Sb86FtYO23h3oKUZb3uwzVrswqU7//WyKiaf81bb0XIsatN+fm2IpHOqqZRubO01NHzgxWegViB8Lv65ExqOouaz5eLeQ2thXe0pRNhjd2rL8qHC7pznMjar0XtqnEAeCWMTfNni/WNv/Oqk1VjCnZHkOuivHob/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tbq4pYJO9EMQMQQX6qFehs++CyG/2fe2pujODc0yDEI=;
 b=eVFxiFxufsh+4w+QcHL1zWH/znw8IDk23VSXAU6BNJLq1fwSncYoVHHCuFeyRdOBdTPolLUoh1fCVuuZc2fkFVGLE1zQvndleQTXsINOFhCRFzmXjeG46Tam3+PAh6JLnTQy1yCl2nzFLVYqbP8Eus6M7oasnDYA5D6Vh/O3250dUvQl5uZraXpI1dFZ8lW4OYe0BcBPv2X/QGLHHIqL8WQZPdDAmJvLIfhVPQAe9MDcqF4kwU5dAzsP8LtYecbeaDj06CJvR39dX+TxqJoNnPgGlN0pHK3QAclP23DvaIN0PwyjA5tWjXH03eXf9S8sQqbBlcI00/bu28s6znrNkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbq4pYJO9EMQMQQX6qFehs++CyG/2fe2pujODc0yDEI=;
 b=LCiiLBeVh1YkoFJHblkmDcl9XNyh6Y1zCchUxY/WZRcXgIvGA2yz9nQVZN5+KnHc/K5V+y6qRBxv0lYhRjbFTki0VMuNd7MMxuCeA36t65tPrJZtfAfrO9yhwYIdSS98Kh+jfHHyjEN1WCHnLCERUCKr++Q7jVaL9a1RMifo/o0=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BY5PR12MB4178.namprd12.prod.outlook.com (2603:10b6:a03:20e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Fri, 24 Feb
 2023 18:38:32 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c%7]) with mapi id 15.20.6134.019; Fri, 24 Feb 2023
 18:38:32 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Prashanth K <quic_prashk@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        =?utf-8?B?SsOzIMOBZ2lsYSBCaXRzY2g=?= <jgilab@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Pratham Pratap <quic_ppratap@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] usb: gadget: composite: Draw 100mA current if not
 configured
Thread-Topic: [PATCH v3 2/2] usb: gadget: composite: Draw 100mA current if not
 configured
Thread-Index: AQHZR4RI6tyX8XGkuEOVkCA1IEksoa7c9quAgACTUYCAAOVcAA==
Date:   Fri, 24 Feb 2023 18:38:32 +0000
Message-ID: <20230224183830.ox65eocunuvlp7zt@synopsys.com>
References: <1677156121-30364-1-git-send-email-quic_prashk@quicinc.com>
 <1677156121-30364-3-git-send-email-quic_prashk@quicinc.com>
 <20230223201019.3a5njywzchztcs5e@synopsys.com>
 <3a189c0a-e82b-a80b-ac63-0f2c703b2eaa@quicinc.com>
In-Reply-To: <3a189c0a-e82b-a80b-ac63-0f2c703b2eaa@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|BY5PR12MB4178:EE_
x-ms-office365-filtering-correlation-id: 377011d8-30ea-4be5-b174-08db1696548e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YLCUUqmw51wygyyaPNg8xbaFpwbWrlOrpqKBZSSHNP0JD/OFTdMZbpzHD4lHSqs2pYz5pIx//SfNtYtqbSm46Cnd+5YEOiDbJEC3Nc3gVXBAmNdDS9ci8wJLNuZRX5MCu+CSxrNZS5wPCObLjkl34QIRCr0RXfbyicRqTmx1wrZUwQ1681V97OvspSJPW4wIS6EKDnG7a5y+e6LkhG8Re9oeaYSdwLKDR6bqI1eO9PJaeJTZ2hD4ZGJcwe1LxTVgULZDBvRDHnd0g0NMwz6rP40ruhZ1nP993f7lOyrFQSnYW2J/8tVt6Qq7MsSw4ME3+yIdUYlSZsuAg0ieaKqPvjDdWp+rSYe16kFF2IZuNXJXh2lai9E+zaRZ3rRlCVgqY9UeXL3RPV9lies4Qrx4wHoRvxqXvb4nwWUcvFbbPicKdcrjmVwygy9V85m6+GMgV150ygFR52yBf5vUu9umiBJWeqG8HrIxm1vQjlco87/PIDz/h1ULgbV13czELryDHyfj7MrAxQXtvuChX7AOdQ7y8pmGO8mvhAYZcHOFtyRig6uMWS14XgisDNHtCyjM188i/MITvKtaL4DsUJwh/5xvGeRim2qFBfhv21dtlGVko56gIEI0Zht9UhG6a4zjQrdIV6sIAc0HImTluOoNRaGd6Mbj/HCA2u5gut/AME8AAaent1kgz1+WluH8RrdZ8u6G5aaLylzCeVWn6FtGy19JGM9eFM0oFrn/65t6YILdINGZ8t419UvwW0FSAKsg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(396003)(376002)(39850400004)(366004)(451199018)(38100700002)(122000001)(5660300002)(83380400001)(86362001)(2616005)(8676002)(54906003)(4744005)(64756008)(6916009)(66476007)(316002)(66556008)(8936002)(4326008)(71200400001)(478600001)(38070700005)(53546011)(66946007)(6512007)(41300700001)(6486002)(36756003)(66446008)(76116006)(2906002)(186003)(26005)(6506007)(1076003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qzk1VFN1M2c4OXhZMkFoTGQ2dnpERC82bXBYaUFETWMxQ0RQUXNTeHZQMitp?=
 =?utf-8?B?L1ZEYTlYYUNpNk9KY3VCd3ZQSWR3R2x0ZmJFZmZmNVVHUG8rUnVVS1cxRVNR?=
 =?utf-8?B?UUUxS096QnRnR3hyREFQVXljTTViM0JuNWRyVTFKV2k5cS9XcG1SeGhIUGk1?=
 =?utf-8?B?VjlGMWwwYzVIb011eGY1WUJPSXpRV3RrVHpMU3dBdmVDU0kxcHd5eXdzMUE5?=
 =?utf-8?B?QjErUTN2VHd3ZHBvYXNPeWdpVG14L0JlSnlsOE9haU81bjI5SWQ2RXFXS1B2?=
 =?utf-8?B?OTNPbFVrZ1NKaXo1bjBlalpSRWdQTHMyeGV2QmVBNjhuNjFJY2hHcloyMEoz?=
 =?utf-8?B?ZFp6eGJGN216THh2a0FnR3BiWUVxcWVCZlB4RkVoNTd0OEtwbis1NlZWVUls?=
 =?utf-8?B?TGVmWFdmOEpWWVJrVzNxMHhQZ3RqWDZFM3I0YjJDQVU3b016b3o2NmN0azBG?=
 =?utf-8?B?dmJ0MXU3bWQvZk5qWjdSTmRYZ3NCNUVRMjBqOFVzV3R3NVhnK2NiV2o3dnp6?=
 =?utf-8?B?eC9tZkxJd1cvQmtvdmhCOUdmOEI3U3l2M3BESkdQcGVyT2U4anNNR3lXcnF5?=
 =?utf-8?B?MXRBdHZjdFF1ZFZPWXhlaEJpS1lsVFU4MEpleGQrWlpQR2YzTkg1MmVMOGtL?=
 =?utf-8?B?VnhUVmhNb1BwQXAzWWN0amprOUJoWVRpajJxNE5QSEtFZjlzUGtHYUZ2cXpo?=
 =?utf-8?B?R2c3bnEwTmliNmV6dmNpK2hhTGN3eThjQXlkWFVsS3NFOU9SK0dCN0tJME1x?=
 =?utf-8?B?Z1lrUDVGdjRWb205dkd1M3RCWHlIS2VsaW5BZERta3dkcjNMTElwd0djMjVO?=
 =?utf-8?B?Wk5oY0ExRkNodWZzMEdHNitRWWczUDhSVk9PMnU1T0k0amhha0FWTkJrbGlH?=
 =?utf-8?B?Z3JIOTc4djl6Z1NxbXFLbUxCZGFZZllHdWRDMTNpaSs2Y3hRMzBBWXFsMVI2?=
 =?utf-8?B?QVNMUjlBa0x1SkZHcEZjYW9SYUsrb0xBWGhxaXdtc0lFak9MWGdPK2t1KzRy?=
 =?utf-8?B?a2NpcnBxL3ZKZUorazR2QmV5bUR0V0E0N2lWSjMxTmx3clAxZWdYK3R0WDZ4?=
 =?utf-8?B?YnBTcVZqd1ArQitBVmVxRlZlTWJBRW5zUGxZbFZrU0VtK2RjRGsxZjlMcXlI?=
 =?utf-8?B?NjhwOThGVnZpRXprOEJyaXAwQlZuVldsVXI3UDdIUjRZckxXUW8weDVURUVU?=
 =?utf-8?B?QThxN293Y0NSWlBvRy85cWc4WlRKVlBDUjcvZWRidkxKa3VpQ3pFSCtqSTNk?=
 =?utf-8?B?bHZtVm54OTNJZVhjK3pzVUNaSFlmWUNYeEhPZmpEKzg3Mkp2WHEzOGF6Ykcr?=
 =?utf-8?B?ZDFBWWEvdUZRSXB4ZnhBZXU2QjFYRkl6R25NRnJrQUhDN2s1WEZtNTg2TWw2?=
 =?utf-8?B?dDR2M1MwZ2JYUmcya0V5UjVzaGJSNzNwem82SWFGRmlqYVFwOVg5ckdEUTgr?=
 =?utf-8?B?Yy90NXNmd2pDUVBwRVhOZjNIVGR3L2VlMVdiTkFaWUQ1eWo3VVQ0SmROV3J5?=
 =?utf-8?B?elBjUGFiR1U3M2dXSU9NVjRYTUxiY2tKZVBlbkh0OWt2dmpGNVlESW1ublBa?=
 =?utf-8?B?ZVpxc2VyL1JpVEVHdGlkd3g4VDBZU0hPcHFDTkxoa1Jpa2FkcDRCWWxFd3dp?=
 =?utf-8?B?M0xsZUh0NC8vVm5TRit6SzdmMVFaeWMwS3ZQWGxxNVlha3E5Vi9EWC9WZys5?=
 =?utf-8?B?bUJqdTIyd2xYdDM4VTFGWTJOWG5GbUVIaWtJRnNxQTYvVGN2SVM4VTVvUiti?=
 =?utf-8?B?SWpqRUdUTUZzMVBDWGJTcXdDREhVYmNoY2NCcVozZSt4a0xpVkw1Mzg2OVY0?=
 =?utf-8?B?NVJ6S1pqM1FLZzBBb1N0bURNcnFBMXJvTmJ3cW9tcHo1K3l4NE9BODV6M010?=
 =?utf-8?B?Q0xBdGt1bFUyZWxGcUF1VVJ5RW8wbkJpeVVMZ0FPNGcxMmxTWUlJdUhIMlF5?=
 =?utf-8?B?Y2tVSXdnVmFKRlhNcWpMVmlzeHdyV2k0UlliVkV0U3FYS3VheUF1VkJpOWdG?=
 =?utf-8?B?MlgvckJPR1lSQWl3QUdkVXR6NjhmeUdRLzdiSW00Tk1QVnVPb3RERTlxWnZm?=
 =?utf-8?B?N285NGYwbE9ueEdDZUNDcXhQQXJidzh1QUZ0aXBIdGZXQkZqVUlIK0FYaEJC?=
 =?utf-8?Q?f2CHUbwXWBxXj3ZbvYcqNV4DO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3DCFF8310D1BB499CB30E36EE6731CB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?anF1eXVyQzRDcnM2MVpWMHZmdHpYeXRLU1ZFajVJbXhHTEdaMHRSVUhwNVVE?=
 =?utf-8?B?bGR5R3NZR0krTzVoMHU5SGhvbVlyMjAzU1cyNFZFOU5mTXJpdW1XOXdFaW9m?=
 =?utf-8?B?cmpOMi9HWDk3REJhMEQxbk43Rm5MRW5vckV5UUhrTjhPbmNhTjZWUC9mOGFM?=
 =?utf-8?B?TFQybjNub0gyWU1GSjVHSDduQ3cwdTQrdEVkZHVOemowUGM1eDZTMVByeTVP?=
 =?utf-8?B?c2IxRSt3OWt5YlFaSjhTVXl1dVZxdzVXa3E3V1BwV1RXVWQvTFVsd3h5TGxn?=
 =?utf-8?B?dmp3ZjRpTTduakVHRkNjNkhRYmlKcjNHUVoxVUo1QXRhTUhoN0R1d1E0ck14?=
 =?utf-8?B?Zk1BSkgyRWEzeGpNVDdiT2JXdTcwb2thT1BaVHpMenlkVWFlNVlkdEJ5clBo?=
 =?utf-8?B?SmlOaVZ3dUtidjBING5SNnVjcHRjWmNhR2pHckI0V2U3Uzczcmhac0ZnWEZn?=
 =?utf-8?B?L2ZxZDlhdC9nVS9tdUF2WTE2K283bkk2dkhNZGlwU1h3RHhpQ3pieXVoWUJI?=
 =?utf-8?B?WFBtbVdWTUNDcDJMWmpsYWE2SXB1M21RQVI4TW1VM1Y5eVM3MElMWHF5cGMx?=
 =?utf-8?B?ZUZ1MTh4RnY5RjRML3dZWlg5UkZDeWpsWXVtMi9lcm9QVFlnczBjWUsrQnFV?=
 =?utf-8?B?ZEhkYW9LQ2k4dk5TNDB4MS8rQ2dNdUhIRFVzMklPbTg0TGhvbHBQT2NkTjZa?=
 =?utf-8?B?dTI4MENsV21iZFR0anp3OHNEbVEyR3JBM0hhYlFFVHJPTmJ5NXR0a1R6Nm5n?=
 =?utf-8?B?RmJBYTZyNWVhRGJaRkJ0TWVaN1VmT3VDaUM3a1VKZm5sbjVkVStqbXdCY251?=
 =?utf-8?B?NVg4ZVg0QWZzeE5QS0FhV0RYWEJGYzBLVVBjN2RleWlhWnFEMlJOamJGN0Jt?=
 =?utf-8?B?UngwZ3pselJWVTd4bUhNYXpndXNPSmRpb3FtdWNueWJsN3RKbmdiRW9SemlV?=
 =?utf-8?B?bDlvSHduem54S1pYSTBSa1BmKzgvZmxwRVlTc1VjcGw4MW8rYkhLREhlb3dB?=
 =?utf-8?B?bmgvTk9TMVZnc2IvUmNLUDM1R203Wm9EWFRGalZjTGs2K0ZqSjFnakF1bEtR?=
 =?utf-8?B?VVlGL0VUOTlseXAwNjkyaCt3ZFd6UEJQY1ZNdk5aNmJSUnphMlpaNXdCQkFv?=
 =?utf-8?B?Qm05Yjg0dXFHTXpISUdTREdzZDJROEp5SVg1b3dET2tjS3F2R2ExaTdjRjRB?=
 =?utf-8?B?LzZCaDNyWU5FTXdaT2lmOGpvVDMzajUwMG9FRWNMYUJkdUZRazBYNUxLK3Rj?=
 =?utf-8?B?QmMzWi9nN1FhaUdCUjhwTUgzYVljUWdRempjTXYwUm1saE1nQT09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 377011d8-30ea-4be5-b174-08db1696548e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2023 18:38:32.1975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AYSysLjpZHbNY/qUtCeKb3ce06+It5x+KGi2ZTcDKPd/+3qG7NeXEtav2diGaj6KU6r1zD/ENuV6uVMlsDWSoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4178
X-Proofpoint-ORIG-GUID: xmF8lJu8UoYytjiyMYwxJHiw9H6q0uf5
X-Proofpoint-GUID: xmF8lJu8UoYytjiyMYwxJHiw9H6q0uf5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_14,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 adultscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 mlxlogscore=573 spamscore=0 suspectscore=0 mlxscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302240147
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBGZWIgMjQsIDIwMjMsIFByYXNoYW50aCBLIHdyb3RlOg0KPiANCj4gDQo+IE9uIDI0
LTAyLTIzIDAxOjQwIGFtLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gT24gVGh1LCBGZWIgMjMs
IDIwMjMsIFByYXNoYW50aCBLIHdyb3RlOg0KPiA+ID4gQ3VycmVudGx5IHdlIGRvbid0IGNoYW5n
ZSB0aGUgY3VycmVudCB2YWx1ZSBpZiBkZXZpY2UgaXNuJ3QgaW4NCj4gPiA+IGNvbmZpZ3VyZWQg
c3RhdGUuIEJ1dCB0aGUgYmF0dGVyeSBjaGFyZ2luZyBzcGVjaWZpY2F0aW9uIHNheXMsDQo+ID4g
DQo+ID4gQ2FuIHlvdSBwcm92aWRlIHRoZSBzcGVjIHNlY3Rpb24gYWxzbz8NCj4gPiANCj4gMS4y
IEJhY2tncm91bmQNCj4gMS40LjEzIFN0YW5kYXJkIERvd25zdHJlYW0gUG9ydA0KPiANCj4gRGlk
IHlvdSBtZWFuIHRvIGFkZCB0aGVzZSBpbiB0aGUgY29tbWl0IG1lc3NhZ2U/DQoNClllcywgaXQn
cyBiZXR0ZXIgdG8gaGF2ZSB0aGUgcmVmZXJlbmNlIGluIGNhc2Ugd2UgbmVlZCB0byByZXZpc2l0
IHRoaXMuDQoNCj4gPiA+IGRldmljZSBjYW4gZHJhdyB1cCB0byAxMDBtQSBvZiBjdXJyZW50IGlm
IGl0cyBpbiB1bmNvbmZpZ3VyZWQNCj4gPiANCj4gPiBJcyB0aGlzIHJlbGF0ZWQgdG8gYmVpbmcg
c2VsZi1wb3dlcmVkPw0KDQo+IEkgdGhpbmsgaXRzIGFwcGxpY2FibGUgZm9yIGJ1cy1wb3dlcmVk
IGRldmljZXMuDQoNCk5vLCBJIG1lYW4gYmVmb3JlIGNvbmZpZ3VyZWQgc3RhdGUsIGlzIHRoZSBk
ZXZpY2UgY29uc2lkZXJlZA0Kc2VsZi1wb3dlcmVkPyBTaW5jZSBiZWluZyBzZWxmLXBvd2VyZWQg
bWVhbnMgZHJhd2luZyAxMDBtQSBvciBsZXNzLCB3ZQ0KY2FuIHVzZSBVU0JfU0VMRl9QT1dFUl9W
QlVTX01BWF9EUkFXIHRvIHByb3ZpZGUgbW9yZSBjb250ZXh0LiBJZiBpdCdzDQp0b3RhbGx5IHVu
cmVsYXRlZCwgdGhlbiB5b3UgY2FuIGlnbm9yZSB0aGlzLg0KDQpUaGFua3MsDQpUaGluaA==
