Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9CB71900C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 03:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjFABao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 21:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjFABam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 21:30:42 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD7C93;
        Wed, 31 May 2023 18:30:41 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VLH2Hh023097;
        Wed, 31 May 2023 18:30:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=57M5vbrnueEgycmhoO4wszsriogdDcYJkmefM/hbMFM=;
 b=Qrrux8ke76zSgkEyQ55R7v/5XRjysxZqXMSMkwfw47Pd9mRVILtOqAbRgxY8wKelSC2o
 O4nEAzwxEtTn4e9MNa/AmYwZKKUKufyiB8IPtQhtB3k44v2ctJ77nRU1EKIVqXJl/kz4
 /PH5xGr9sC83KpRf7z6BZpd+mC2+bUEvFWV6269Dj0eJkCLizIAemzMvKJlIGFWxI/uB
 jyIiKBjYG5/1Qc5UOKBG4LQwC7XSpNJICY/ycplIZSvCZB2OWAdlbsTHafYmIPqsNF1v
 CAN6Bl5IxibzbttgX8qOstEihOtHqE2+b41c7F31Nk3uoixjGAQFvPY0t1jnmgpuuMyH eQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3qugge63a6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 18:30:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1685583011; bh=57M5vbrnueEgycmhoO4wszsriogdDcYJkmefM/hbMFM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=G+37mdPEdgTlQtAGfvov+OH+l9+IWMDWxz0f63KQ2RidO+gGZKTt7f1YFl1qN14br
         m0mxKM5F3AqZ7ENEN0GXHHgHYTedWLCl1Jj+eA/LmgMIh1kqlhS/+Dr0FjaPOhPzNi
         DBZWpL51UvjGI/G9qsSfsMsih1V1UtY4Po+dKoGmNsloRX6qmO9F43v7vdOWSTEayI
         Qz2HS8OnX3CLjexq8zrz8TUkWJFF2NfrgRAdXPLzJVm1hNF7zNRlsharZxNyRRC07S
         HF28F6G+/TS8p5tf3V0MyIewLrBtdDxGgZfKSnSmFR5FuH/I3/IN1WqFxbNmWUoY+2
         IzUexIDbB85cQ==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 03A5D40147;
        Thu,  1 Jun 2023 01:30:10 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 5F893A0062;
        Thu,  1 Jun 2023 01:30:10 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=DBW/4VUB;
        dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 43C4A40136;
        Thu,  1 Jun 2023 01:30:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQXNxfZ+KSBMMZ2wAPNymGrnW3p0VDxmgeV9iPYk7WA0PuiJbNktH+tyFzP34zJGGgUFS+6jGI1BD3PisQRpAqtu6TVc3CJ9+tF+CcwSBkSrZOVQwZRFKz3u8vFAWpycENJlEd2JryB4szDhXr/Lzwe5KEC4kXbYXVQxj4kU2BGuAYJLkPsME5rMLIqNIxO9fDTO9bilYGhl4qFtBOGOsSR+iPfRyAKWdi7UBY3lszv7vgmJrGp11Orrotnl5PNNFu8i8Zs/bYhWCX6KeU5xeXiMl2aSheYppZm+0nfkYHLgKWkiY9l98rZ16amrzDD4KuecjE6BtHVI4H7ryuigMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57M5vbrnueEgycmhoO4wszsriogdDcYJkmefM/hbMFM=;
 b=KDdcLf836AwHvRjZPORxNuhl4EdRV5F49Jp8FqniNFzGCFBF7A8WQfV94xOHNJv9PgrKF947ZzagNZbfcfwLedZ1CtgGgUa2UJ3Q4A62KZRSag/7yL4UdffNQeDnpqxTIxec3xMT+cCzCb5Rzze7ySiBrwjpWeX3oa3RsK/1Qqbzl9ffi8CNvhf2YbpCbtcVI0OT3yEv2G7Ysb7PLjUU3fEcMaFy2xfbWxlm6XD3e2gv6tu0q2qxdBMn43iSpLCp5P+P7n7qd7QKbAh3nZVKUiHPS6F2e/YV7Bsva/TJ2nEMGWgJGPV6gRR/UyyjsSil0mwoiGWj+8OnxRZHJixHPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57M5vbrnueEgycmhoO4wszsriogdDcYJkmefM/hbMFM=;
 b=DBW/4VUB9acCGC2Rv1rqKo7HsTo2owLXWRMdx444HfL/eQ3xmBXfQ1HVz2SO+9fYpBFZzBLilqYyIBD3KqQXVXUQzetaYesfj3cXbqfmdKazKPtSr5Mbu/21YOLNrJNKpBtur18QVWUSODX6VVJn8i/EKZ+bJwaMOLLGSkj+wKw=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CYYPR12MB8653.namprd12.prod.outlook.com (2603:10b6:930:c5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 01:30:03 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3400:81ff:f191:b312]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3400:81ff:f191:b312%6]) with mapi id 15.20.6433.022; Thu, 1 Jun 2023
 01:30:02 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Elson Serrao <quic_eserrao@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH] usb: dwc3: Skip TRBs while removing requests in
 disconnect path
Thread-Topic: [PATCH] usb: dwc3: Skip TRBs while removing requests in
 disconnect path
Thread-Index: AQHZk/nVxQI+NeMmWkCDLCh1fe8pO691BNiAgAAbNgCAAAkfgA==
Date:   Thu, 1 Jun 2023 01:30:02 +0000
Message-ID: <20230601012953.47xh7meyr2woowpc@synopsys.com>
References: <1685562871-17024-1-git-send-email-quic_eserrao@quicinc.com>
 <20230531231951.vg7x2w7gnnm77alq@synopsys.com>
 <38255534-f242-dc06-9216-1568da9b0285@quicinc.com>
In-Reply-To: <38255534-f242-dc06-9216-1568da9b0285@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|CYYPR12MB8653:EE_
x-ms-office365-filtering-correlation-id: 0a0507c3-104f-4eab-086c-08db623fb8ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n5+F/9avtcQhZCw8vV7y8md238EYBLEyZlGyCdIF9is4Pt6ulvPrl/zAJVLGoV6228EU1/jNw7S4QOWYXGou2TIdXNNdLeGTw92nETDFyhM/+S0B3bi+guT5kG0RTDW6XzitCnwlyoE/ICHEFogmYiFTbZEb93hMoD1VOXHi/cUh9ZqkhvU0zUnp4r+8bvlFmcB1hxd5XtcPjlL6Ysikpztvbx6m193zMlktWQFJIguOkFz5go42r3GvftSrFAbw/rsiz6UWyoto0wCkEb1LKOmz2/Y1t249AMEBMc3rah7LalVwEd9Emqqjc0ve+H4N8erZ33Ix/BuBOjHbcVeBZEz1OeLoxYNUhA3GyZOfBJKfp+Jn9x3e4w8irVt0AXhNsxVSZey+aR25Hsxah2e/3EvF9DKLAcK997gMTAOp3/ucX/lLRniuNyIZfVLjHIiQwkWs8ISwn+5fAOfT5E7bAXa7JxSdgy93pvT32fYmGa1ZHake85j20skc3Jr90IToYJ3/2DnR/tAl4yTSnIHAFJUSYtBL/r/qpzhnuUx98ua3WLTZI8w4M/VsXkpvq8pIPvZSejC79BtROfAkwCNbP1cH7X6nvXznlTf4ONeaCavZQhHeY9Xs+5GBsLfRQ4eW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(346002)(396003)(376002)(39860400002)(451199021)(38100700002)(122000001)(36756003)(86362001)(38070700005)(8936002)(26005)(8676002)(41300700001)(6506007)(5660300002)(6512007)(53546011)(1076003)(2906002)(186003)(2616005)(83380400001)(66476007)(66556008)(71200400001)(66446008)(66946007)(6486002)(316002)(478600001)(76116006)(54906003)(6916009)(64756008)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnFvNFgxeW40WFBnNThlNDJTQjFDQmNEc2tJeUZqZ29aYnhBZjlkbzM5TGRJ?=
 =?utf-8?B?L3QwYVR1bTREOHZoWGVtbWlUYmhnaUlvaG95MTdHUEFhU0ptakJMNTNqT1Zs?=
 =?utf-8?B?NE1FakhTaEJCUEJ0aHVIUkxxRFdXZ2oyNmZIcHFNMUxsMFNOSk9ydXRaRXZW?=
 =?utf-8?B?Tms1eVJ1Mm1oazg4OXVDM0VJTGQzb05uY01nTnBUS2c0K1ZoYWhUTjJlKzM3?=
 =?utf-8?B?QzBuR0hGVWJPeW1wejNsa09kQ0lvY0g1SEswdUMxYzV1d3M1YUxuUVdWMVFw?=
 =?utf-8?B?L0dqQ1p3OUt4VU55aExEeGdjajlldm1TUmE2NXVnYkNZN2E5OE9lRWdneVRu?=
 =?utf-8?B?TEhzRkxBcHBOQ0NzN0E0RUtzM3dveGlxOGVVa2VUWWRhREJubmVESzRTNGJJ?=
 =?utf-8?B?NkJwU2RxQ3Z6b1VkaEszeXFCazZIalpUQnVJZThyaFJad0k1VEMyMWljNGpW?=
 =?utf-8?B?aFNld2pMM3YxYmladzladEl1aGQ1eVFUb1JEMkVsNE80VHZGR1puZGlMLzho?=
 =?utf-8?B?ekJ1Tlh3THBseGd4a0dFVFZzdjg0QWJucVBtMUp0cVUxTWtWN1pMVXFkNm5I?=
 =?utf-8?B?YVVZNjJaeE5XYkZGZGR6eWp4TTJoaEdUVUNOMTdhYkV3SDQybytVVXU3ZjRm?=
 =?utf-8?B?ZmQwZklWV25QTm53Qk0wQTkzam0xSDlBZEU2bWdEcFF1OVJWN2NLZjVIcStF?=
 =?utf-8?B?YWNTckFMVjZhMFpSSS9NalVVTDJFU2lFK3dZUlgzdGRoZU84Yy9yZ2F3Q25p?=
 =?utf-8?B?RllQRGZSMjU2ODB0Y05xbXNNQksrVG1pL1FUL2FKSUlOeUU3Z01HNEp0RnJi?=
 =?utf-8?B?dGttVHk3S3JqSHg3NXIwRDBpZ0p6bmdZRGxxa0dUNzdFb254UkM2QjhkbjdI?=
 =?utf-8?B?K0FiajNDTWQyTjB5aFZXUkd2UnlHeVE5WkhQckVwRWlYZGJKRXcwcVNEQXRm?=
 =?utf-8?B?MHR0dkFaV3FPUEplckZxV3F2TmtGR2NhSmpMSFZsb1dVQkRzQS9ETEM0Ym5G?=
 =?utf-8?B?ZlVjQWNNbVo3UEN4andTRkR1aDNGWFJkRU9vWUEvZUFmUEtQYzFyWnhuR054?=
 =?utf-8?B?QUg3NnJSdVM3clhUQkxYemJTQ3pocHBJdFFDTVlqdCs4WE8vL0Q0SmRXY2FW?=
 =?utf-8?B?ODA1Z0o2S0hUT1QyYkhWR2RudDg1MThtWmlDekRQVitGRklSSHRWYVQ1ZmFB?=
 =?utf-8?B?dW5uUVhvZjNGaXpkYjl5MlRLdm1YV1RXL1g0Q25zSzFacWk2YzloY0NvNlJz?=
 =?utf-8?B?SzUvOU5HRmlsbFlrelpMbCtHTnc1eHRuNVhiRjNJUkExTFVTSFhwcVBTWVhi?=
 =?utf-8?B?VmRlQWhvcm1BcE81RFZYMDcvTzhnVGFrb1ZLTkxQNXB6d0hCSWYzM2pVTXhZ?=
 =?utf-8?B?RTliOE9DQ013VWN1Mk1xVFk2QmthZ3o1NTNoK3hpc1ZOelBmdXBUdFEyVkdt?=
 =?utf-8?B?cjJMVnNYRk9kNkJUd1VZSnUxTHVWdlE3aXJGUzdDL3Bvd3FiL3FHNnJLQSts?=
 =?utf-8?B?WDhBeWlJWUNzbXlVNGpPMTNibTJ4YkdEUjlnUFJneVZXU3NYcFB0VGRWYlIy?=
 =?utf-8?B?dGFrNitBL2dCdHdJQk81dGNNVW5GQ2UwZnpmaTRuRnpCc1hwMGR1S1VtTzF0?=
 =?utf-8?B?bE8xS01XakFDeHU4SU8zUUVmY1I3L2Nzbnh6endkc1BlRzFNY0Z1YUluM1VN?=
 =?utf-8?B?d0dhTnllcHk3YmlsUDBlTld6eUlsemVmdzhncXpLdEErbUVBQ0VWVEV4dnVM?=
 =?utf-8?B?VnB3eWlZaTFQa2Z4cTlBSFo1MkV6ZmRVNzhUL2FKQWlsVTBGM3l6R2pvWkVU?=
 =?utf-8?B?RnRLSTZPZ05waXZCQjZwRWRPQ2tFOTh4bXhINm1mejM3ci9nL2hGQXNHN0hE?=
 =?utf-8?B?WVNsSmF6YWJLcmNHd0pjaENMTmdUTW9mTXdaQ3JvSjZVTVZLaW8ybjhDVmZr?=
 =?utf-8?B?SXZGSk90bCt1cW4xdUlPQlZoM3NMb1IvK3ZmMzJiV3RScU1PNmJkekthaTFR?=
 =?utf-8?B?bDY1eEdzL2tSQ3U1WW5vTWhMWUMxc05HSGlDUEs2WEJkS2ZsV2JzSlBPWHRY?=
 =?utf-8?B?L2NzemNtM0FkWFpnOWRMcWl2dDlNb1RramJGMHpWc0RUcGpmdFl6ZEd3UkZG?=
 =?utf-8?Q?735yFzm9JYoAwCf2SuBXteW+r?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6991597A3C34954E8E58B7350BE21C7F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HB8ULRqvar89XZAz83od2Pi6BDrqUbGRcbfMi52ccQIJkapgolqbmqjs250b7ftCKxPq70CS76gZS8pAeoqB6DdB6w5Ifo6kSVOyNq11IkdFttz+EQkr13nR34l8Ip62bk/jzl1GKMXc2Qnn6eIQwWKoruDYUp/0OHGjLxhMpFCUK+G8NLN5a7QoawafKX4nJqm0BEOCuhkmDxWp4KHEqQaL3jgESmJ0RGy+V7Our7++3qvrHmOYX/qH+BCwK/mFVKxFbCWz6Z32d3QinmC2iL4qnplp2xD0e3mRfrxxO4ajQbxJLnVxyuy+LaqI0yR+XzVeuZijc5Xylec+IparlqLCJxQL24B6AOM2Qp1N7ShvDse6Kh53+SgNdAMthMqtPz+yChTab/OfOubT7rhreFJJ2WpcVwaIAJWaUPAm21UL82Jw9kqmJeyPMCLDeWJ0+UTzYCnRrNy6BZck2rZSz0RFvgXzES8U+rLdgXTjL1MW1lwWtb7ii4OWyXrIoVgNOSqdr9kCCXBCQVNVluNJ1GzK2buZ0nEq1S+AdGk2jcQKZm1SirQhO2OKZ0lWFTerurhr4JsZSLHeFxKxnnS/3koQOPrpV7yXqywv2K4R3KjmPdfvZE7v1MfOhakO64lQgDVjTLZmC+NHrjKE+9fQXgq9DK2wiJWmKg+a+vBF1PDYz7afIPSrqFzkZsXCwiEvYEIfADpnu00rxbx+1SA007N0wVGQmsHN5P3u5eOmpAUNs5oLR938IAGNMO5DiMLdJyK4gO80z5Y31b7JJEYcnAI3CWtsHzcaOthqwbAqHZAPhVYV3L2+ZQGDfHmdI/u85RQJ0s2N4iUqGivKGIl+dQI4bEdgeUAg4tgLq52IHTAhN3nEtKeHWTEk3kvBh00j
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a0507c3-104f-4eab-086c-08db623fb8ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 01:30:02.7854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tj3gQxatBQCs3Pd6fTQaFjIIwGYkSvkvpKUMYsHmHfWXItTCqIZK9OncT/0no+sSd4ysF/7IwxJ7EGaskhOPwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8653
X-Proofpoint-GUID: If52Rrp12ER-GXqf_b17xmBHWgQaA1Od
X-Proofpoint-ORIG-GUID: If52Rrp12ER-GXqf_b17xmBHWgQaA1Od
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_18,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 mlxlogscore=754 bulkscore=0 clxscore=1015 mlxscore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2306010009
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBNYXkgMzEsIDIwMjMsIEVsc29uIFNlcnJhbyB3cm90ZToNCj4gDQo+IA0KPiBPbiA1
LzMxLzIwMjMgNDoyMCBQTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IE9uIFdlZCwgTWF5IDMx
LCAyMDIzLCBFbHNvbiBSb3kgU2VycmFvIHdyb3RlOg0KPiA+ID4gQ29uc2lkZXIgYSBzY2VuYXJp
byB3aGVyZSBjYWJsZSBkaXNjb25uZWN0IGhhcHBlbnMgd2hlbiB0aGVyZSBpcyBhbiBhY3RpdmUN
Cj4gPiA+IHVzYiByZXFlc3QgcXVldWVkIHRvIHRoZSBVREMuIEFzIHBhcnQgb2YgdGhlIGRpc2Nv
bm5lY3Qgd2Ugd291bGQgaXNzdWUgYW4NCj4gPiA+IGVuZCB0cmFuc2ZlciB3aXRoIG5vIGludGVy
cnVwdC1vbi1jb21wbGV0aW9uIGJlZm9yZSBnaXZpbmcgYmFjayB0aGlzDQo+ID4gPiByZXF1ZXN0
LiBTaW5jZSB3ZSBhcmUgZ2l2aW5nIGJhY2sgdGhlIHJlcXVlc3Qgd2l0aG91dCBza2lwcGluZyBU
UkJzIHRoZQ0KPiA+ID4gbnVtX3RyYnMgZmllbGQgb2YgZHdjM19yZXF1ZXN0IHN0aWxsIGhvbGRz
IHRoZSBzdGFsZSB2YWx1ZSBwcmV2aW91c2x5IHVzZWQuDQo+ID4gPiBGdW5jdGlvbiBkcml2ZXJz
IHJlLXVzZSBzYW1lIHJlcXVlc3QgZm9yIGEgZ2l2ZW4gYmluZC11bmJpbmQgc2Vzc2lvbiBhbmQN
Cj4gPiA+IGhlbmNlIHRoZWlyIGR3YzNfcmVxdWVzdCBjb250ZXh0IGdldHMgcHJlc2VydmVkIGFj
cm9zcyBjYWJsZQ0KPiA+ID4gZGlzY29ubmVjdC9jb25uZWN0LiBXaGVuIHN1Y2ggYSByZXF1ZXN0
IGdldHMgcmUtcXVldWVkIGFmdGVyIGNhYmxlIGNvbm5lY3QsDQo+ID4gDQo+ID4gV2h5IHdvdWxk
IHdlIHByZXNlcnZlIHRoZSByZXF1ZXN0IGFmdGVyIGEgZGlzY29ubmVjdD8gVGhlIHJlcXVlc3Qg
aXMNCj4gPiBhc3NvY2lhdGVkIHdpdGggYW4gZW5kcG9pbnQsIGFuZCBhZnRlciBkaXNjb25uZWN0
LCB0aGUgZW5kcG9pbnQgaXMgbm8NCj4gPiBsb25nZXIgdmFsaWQuIFNob3VsZG4ndCB0aGUgcmVx
dWVzdCBiZSBmcmVlZCB0aGVuPw0KPiA+IA0KPiANCj4gDQo+IEZ1bmN0aW9uIGRyaXZlcnMgZ2Vu
ZXJhbGx5IGFsbG9jYXRlIHVzYiByZXF1ZXN0cyBkdXJpbmcgYmluZCB3aGVuIGFuDQo+IGVuZHBv
aW50IGlzIGFsbG9jYXRlZCB0byBpdCAodGhyb3VnaCB1c2JfZXBfYXV0b2NvbmZpZykuIFRoZXNl
IHJlcXVlc3RzIGFyZQ0KPiBmcmVlZCB3aGVuIGFuIHVuYmluZCBpcyBjYWxsZWQgYXMgdGhlIGZ1
bmN0aW9uIGlzIG5vIGxvbmdlciBhc3NvY2lhdGVkIHdpdGgNCj4gYW55IGVuZCBwb2ludC4gVGhl
IGZ1bmN0aW9uIGRyaXZlciBpcyBmcmVlIHRvIHJlLXVzZSB0aGVzZSByZXF1ZXN0cw0KPiB0aHJv
dWdob3V0IHRoaXMgYmluZC11bmJpbmQgc2Vzc2lvbi4gVGhlIG9ubHkgcmVzdHJpY3Rpb24gaXMg
dGhhdCB0aGUNCj4gZnVuY3Rpb24gZHJpdmVycyB3b250IGJlIGFibGUgdG8gcXVldWUgYW55IHJl
cXVlc3RzIGFzIGxvbmcgYXMgdGhlIGVuZHBvaW50DQoNCj4gaXMgZGlzYWJsZWQuIEJ1dCB0aGF0
IGRvZXNuJ3QgZW5mb3JjZSBmdW5jdGlvbiBkcml2ZXJzIHRvIGZyZWUgdGhlIHJlcXVlc3RzDQo+
IHdpdGggZXBfZGlzYWJsZSgpLiBFdmVuIHRob3VnaCB0aGUgZW5kcG9pbnQgaXMgZGlzYWJsZWQg
d2l0aCBjYWJsZQ0KPiBkaXNjb25uZWN0LCB0aGF0IGVuZHBvaW50IGlzIHN0aWxsIGFzc29jaWF0
ZWQgd2l0aCB0aGF0IHBhcnRpY3VsYXIgZnVuY3Rpb24NCj4gZHJpdmVyIHVudGlsIHRoYXQgZnVu
Y3Rpb24gaXMgdW5ib3VuZC4NCj4gDQo+IEFzIGFuIGV4YW1wbGUgYmVsb3cgaXMgaG93IGZfbmNt
IGRyaXZlciBhbGxvY2F0ZXMgYW5kIGZyZWVzIHRoZSByZXF1ZXN0cw0KPiBkdXJpbmcgYmluZC91
bmJpbmQNCj4gDQo+IEJpbmQoKQ0KPiAuLi4NCj4gZXAgPSB1c2JfZXBfYXV0b2NvbmZpZyhjZGV2
LT5nYWRnZXQsICZmc19uY21fbm90aWZ5X2Rlc2MpOw0KPiBpZiAoIWVwKQ0KPiAJZ290byBmYWls
Ow0KPiBuY20tPm5vdGlmeSA9IGVwOw0KPiANCj4gc3RhdHVzID0gLUVOT01FTTsNCj4gDQo+IC8q
IGFsbG9jYXRlIG5vdGlmaWNhdGlvbiByZXF1ZXN0IGFuZCBidWZmZXIgKi8NCj4gbmNtLT5ub3Rp
ZnlfcmVxID0gdXNiX2VwX2FsbG9jX3JlcXVlc3QoZXAsIEdGUF9LRVJORUwpOw0KPiAuLi4NCj4g
DQo+IFRoZSBlbmRwb2ludCBpcyBlbmFibGVkIGxhdGVyIHdoZW4gc2V0X2FsdCBpcyByZWNlaXZl
ZCBhbmQgZGlzYWJsZWQgaW4NCj4gbmNtX2Rpc2FibGUgd2hlbiB0aGUgY29ubmVjdGlvbiBnb2Vz
IGRvd24gKGNhYmxlIGRpc2Nvbm5lY3Qgc2NlbmFyaW8pDQo+IA0KPiANCj4gVW5iaW5kKCkNCj4g
Li4uLg0KPiBrZnJlZShuY20tPm5vdGlmeV9yZXEtPmJ1Zik7DQo+IHVzYl9lcF9mcmVlX3JlcXVl
c3QobmNtLT5ub3RpZnksIG5jbS0+bm90aWZ5X3JlcSk7DQo+IA0KPiBJIHNlZSBzaW1pbGFyIGlt
cGxlbWVudGF0aW9uIGluIG90aGVyIGZ1bmN0aW9uIGRyaXZlcnMgYXMgd2VsbC4gVGhhdCBpcywN
Cj4ga2VlcCB0aGUgdXNiIHJlcXVlc3RzIGFsbG9jYXRlZCB0aHJvdWdob3V0IHRoZSBiaW5kLXVu
YmluZCBzZXNzaW9uIGFuZA0KPiBpbmRlcGVuZGVudCBvZiBlcF9lbmFibGUvZXBfZGlzYWJsZSAu
DQo+IA0KPiBUaGFua3MNCj4gRWxzb24NCj4gDQoNClRoYW5rcyBmb3IgdGhlIGNsYXJpZmljYXRp
b24uIFRoZW4geW91IGp1c3QgbmVlZCB0byByZXNldCB0aGUgbnVtX3RyYnMNCmNvdW50IHdoZW4g
Z2l2aW5nIGJhY2sgdGhlIHJlcXVlc3QuIENhbiB3ZSBkbyB0aGF0IGluDQpkd2MzX2dhZGdldF9k
ZWxfYW5kX3VubWFwX3JlcXVlc3QoKT8NCg0KUGxlYXNlIGFkZCBhIGZpeCB0YWcuDQoNClRoYW5r
cywNClRoaW5o
