Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24CD6F0E38
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 00:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344052AbjD0WNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 18:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344150AbjD0WNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 18:13:47 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7B93C1B;
        Thu, 27 Apr 2023 15:13:43 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33RLGZDE007557;
        Thu, 27 Apr 2023 15:13:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=TQk8beY9HKvlRERql2asskkM6mgA38iDhqN3fZrMaEc=;
 b=bSAnX6tre66NTEkDrZws41v+U9B6QV0tmyD01uCl7hnAWa4J4xSc5ag9NsSy3CbriyaR
 IpayxXLOCqYNTh+J4dCL57aFeuyas27STs72Cq5k5OtsEnitCVJ/Li5KgeK4fxnUSWWU
 tFFfvhWDebam8Jmo/EE4Mj+eWY4wJpd7XjuH7BeRev3YHSfbuwqgFTecwhHCtdhJEJdO
 pgaVCVzOdV4mxxpDGsoJgsuKtYyRmsVJtbt7VIgMD0cJgmldA9AnIc2H3/QcwcQDS/Qm
 EPyrjNu5djRD5rLZfYKGw+oojy6bAFYSZbcqFDoFZfkkLBKgHgncAeY87+ZFPbnZ/mLJ nw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3q4eu71xu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 15:13:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1682633611; bh=TQk8beY9HKvlRERql2asskkM6mgA38iDhqN3fZrMaEc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=evgC+b62bmCPS74iR/R90b9ifXWjImYta3AmwoD/g///i7PK4S+BpIJjwhCN+UNkO
         T7K3a5eptrjCGxrTAhWGi84LIWULSqUI4DNrZUhJIOv8HdXP4yf1BoRHbj6PPLO8FI
         sfyiBFx5X/5rg6xcSW0YbhcD2zFADmU4moeb5S9p5UQ2244PoMo4QWasPLs13I0nfi
         tHr0+ijl/4UtKXp/wOtv9eQgZg/dububL6nMTWADeN86xzYW/PbY26q3t5mvGpTm+o
         5kZGq41Tza22BbTsANJAce8ALiKffRKNxn1Zjcxrg1HmJ5jZr72FY61mrlHjCxL4X6
         Ut6hzh2G9oeSg==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 47E2B40520;
        Thu, 27 Apr 2023 22:13:31 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id CA257A005E;
        Thu, 27 Apr 2023 22:13:30 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=pFrkg7Nu;
        dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id AA72440703;
        Thu, 27 Apr 2023 22:13:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSkWNnjECZ0NHqTB5GT1qs+rG3Ogjgmp1Pxr1oqSXOUHTSfFnGYC0FclVIWsgFue74k310kuzUxtVkfR/6uZ4A4wKqeeHj89iJBWndfns8CpOhk/415XMdDTp5iruLdL6gBkIXPytCe93pw7NrMpP2DEh8TjmLYLMJ/bezw0xSjU7dSNOgIxIlIFFflJphA/6rN6f0mmzVfR5crV+SNTc44lpsiqgLpeOf4IUd7Wwt+apFQpC6TKW2HeNmPIPZizgPUsZwHQ+cEmOe+kSaiFKnWoH1a9/pmLnE/RwG+a8THHtFNC7Mskg+niTDouZwUb8OZlP2/VWyyA0G0Mz2ByGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQk8beY9HKvlRERql2asskkM6mgA38iDhqN3fZrMaEc=;
 b=ZXQBXJyenTMbhiTccpnsf63HO1afIPsNeUAvgSknfeb8OjIECdkswRo0zt9XJxNR9WYHlxc2D4VxqVo1/y/pJBtroPKF3dJU5QGYF4pyuTNirqNcjrtCr4s0/RKFowSHRJsQ6ip04vmBzaPKWW0LHlLJ5WKBIms2CmU8/6HI0ocUdp3wQU5QrD83GOmQJfieFrEcXKWQthmf1YCcXynvbb1ctiRN8v7ascJ+11pXjOySBcixduzbjjPEHoIGPtxfQBO7FvZq77xvhg3KhktugItb5PrwpGAruRUA3fL99zUW+BhLHW9SAd3p5Dl6iqIOJMh6w6+3O2J/MxNpVKwrCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQk8beY9HKvlRERql2asskkM6mgA38iDhqN3fZrMaEc=;
 b=pFrkg7NuW6I4xN2CMxCcQFVCosUl5f6yolAFcbuIDTjE62TA5pTRAeZZaCVgCv5rBZEHmYt310mWGfEt4kIbBTPvzWXPxcxPQhNkUgal/fI2sf47SWGApPJf92WhrR7atFptA7y0wZNtkE1ER8CivEFsRAe6h2aHrcuVygFPtY4=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BY5PR12MB4951.namprd12.prod.outlook.com (2603:10b6:a03:1d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 22:13:26 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::bb79:9aea:e237:688c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::bb79:9aea:e237:688c%6]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 22:13:26 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Roger Quadros <rogerq@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: dwc3 gadget: controller stop times out on system sleep
Thread-Topic: dwc3 gadget: controller stop times out on system sleep
Thread-Index: AQHZeFqc4s3gM7Yov0WTj+Z9vn7u3q8+Ax8AgAFWGYCAAGD/gA==
Date:   Thu, 27 Apr 2023 22:13:25 +0000
Message-ID: <20230427221315.nmvy32j6lfxlsmdk@synopsys.com>
References: <24c9f271-ed74-fffa-a49f-6e83da857593@kernel.org>
 <20230426200140.xa4unnbaw2vog2je@synopsys.com>
 <dafed705-292e-6c03-7599-1b1374b95122@kernel.org>
In-Reply-To: <dafed705-292e-6c03-7599-1b1374b95122@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|BY5PR12MB4951:EE_
x-ms-office365-filtering-correlation-id: fe2dcdf8-2dff-4669-c571-08db476c9f76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Uvv9c9UiqxkscIzMI7IAm9hehKPbQlso42bl9A3wLBSbE38xc6+TLss/gpdUJ9lBsTFlRWrzv7imcPgomZ2b8/KA66WFI3ZmBA0VYvPBifyZ7tthIdwkMzGP6PjzOtQSaGk4h30vg6MwLHTio4KJFvn/2dKXfKXxa6ZzYOH7AqMvE+bCleBTVRhARnXdeWqJhn5oyfhw6O+TedD+TQa8T9sOSYmOSuGAgRdbm1uESW2/5sQw336j6NGNa7sAxSUYjkJq5cIrtiB0LGJfnhgMUTgpbNdYITaUiMhpbdFZpIiNu9i3Hur+DqkZdRhbKh564YEqiquql6iD4W5lTA4wXDa4Gaoua1tnYg2YEuRBXY6iD0aq5rCEuGeEwFX+iEXue2tyO8WqkaqVQrIW0FmgNbdHTSRADMcJjMwE9EwkMKmSO5tTI8gw5+iDlUQvTwC41rqQpUFmU4edY/Ce7KuVqp2cdIzcE+kz1auJNtgcuqIMF9qAKiw+bcIyhtWObFXRMeoOqFnAZtEQMu0n3pKRWTnOoVUvE0/5pEv0KJGTbTmGw2/KbdkYH2e0x9InSwZq80iwUDNo1z2FxpvrQZRzR3MHLzQg3vMuEQzoDvQYzknVIJ8EeRYecFYayOr3xJNG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(376002)(39850400004)(366004)(451199021)(38070700005)(478600001)(36756003)(54906003)(38100700002)(8676002)(8936002)(5660300002)(2906002)(122000001)(316002)(66946007)(41300700001)(66556008)(6916009)(66446008)(66476007)(76116006)(64756008)(4326008)(6506007)(2616005)(1076003)(26005)(186003)(86362001)(53546011)(6512007)(6486002)(83380400001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXZKZ3N3VVo0NEJCU05iWEFyY1VWRnJ4MGFHTUJQdWh6Y1RrTERCSk52cUdU?=
 =?utf-8?B?eFFJdjhISEM5OXkyY2JYaEVaenRiT1JYc1Q5T0hkSFp3ckw4V1YyWXFRVERI?=
 =?utf-8?B?bG5JV2dKRDZYdVY2S1JJL2hHRFJOdjZORUlPNTYySVkyYW42V3hpc1UrUVNM?=
 =?utf-8?B?VkJVMURGRnkxZUNDQlVYaUZmYVFGdzJ6Z2ZyVHcyZSszYUdPakNadmVsTVJv?=
 =?utf-8?B?RWFzTHhiQ0IvQ0JTMFdrNnhONUVyN3Y1Vm9VMUhsTG9YTExIT2NQNVVwZVZS?=
 =?utf-8?B?cnZtcmo0OUFFOExaZ285MnkyQUpLRm5oK1NQeUFUYjdUM2poRUFOTU9NNFRl?=
 =?utf-8?B?NXdwalIyY0xORTAzVDhFa25aV1FXOXZuZkxPclRkN2R0amlhTSt4WEtQZWJk?=
 =?utf-8?B?dUZRUWVIUTBzUlRROWFEQzViZ0UvaEN6MDVZTXUyb2NsV0p3cGVXNnhFdkYw?=
 =?utf-8?B?UlRqSmhoYUIwRGxTaWtGVTU2N29hbVh6QWgvR2ltMHRDTzRtemJVanhldC8v?=
 =?utf-8?B?dHhIUWZaVWYvb2R2YnlCOWg4VXdBZHcveXA1eEtVT25FOVBoeXdkakprTW5N?=
 =?utf-8?B?RzRFQUppdS9wSHlzM2hyVEY0NW1vTHdGdGZuNlM0bGFaSHFCWEFsWE51eDhK?=
 =?utf-8?B?L1Z3U04rNE1vaCtySTBad3ZIdklCNGRHd1g5b0xIRzJzZkdFWTdTRENOMEhj?=
 =?utf-8?B?N2ZCbXlIanBkTHZjUUxZVktodXh0eDMvbUVRMHIyMXFzWmJ4WXRYcTdJQ3ZO?=
 =?utf-8?B?amEzc2l5QU12dlY1cFI1TFp3RjNxQzB1SEdFb3BIaThEN0owRTkvd2s5bmxY?=
 =?utf-8?B?QzdPQWdxVmV1MVZHejBnZElpV3IvV3pab1A0Q2FEVk5OejZNdzdyZ1BodFQ0?=
 =?utf-8?B?d1RkaUxBM3Y0cjUvbHpnSThlTkZRTkdrdm5md1hLRnd3WlRady9ibjhqd0F6?=
 =?utf-8?B?dW9LTGwxZnJHUUFBcHE0aWY3L29iRDg2UEFRdlVOcW5HOHZkbmFKWEpMRWtx?=
 =?utf-8?B?NWRDa2ROU0VLZmwrZXhPUG45OWtzeTRHaklkU1A4NUJPS2p3SSt4cWtRem9O?=
 =?utf-8?B?bDIreXBkSWZycXhmVXF4YlNscDlUUTc0V1ZvQkN4Wmxrem5BNXdvTFZlbVM1?=
 =?utf-8?B?ZnNsUUxoWm1jMk5GU3hQT205UEowUW0xWGdKQkRwQUpYRG5UVEpCejluTnZ5?=
 =?utf-8?B?MitJbEd4QkVXUmRXQktadHUzZjFwZkhVYjNGUS8zR0twam5PMVlKdEYvaWxr?=
 =?utf-8?B?aStkdGJ6bjNVWlFpR1RGZitRWDNPWWJUbFB0MEdzYzJqbXRMYVkxQzRHc3Mz?=
 =?utf-8?B?T3J0TTN1RmVsYmxySjNSMWxpOEZsNU8wL1l4dWVKZmlKZEFnMDZlQzAvNEdU?=
 =?utf-8?B?QXF6eWU3T1U1M0FwVnhtdGZJSGNycS9EL0dDMmJtakplUnc1OFBXZ3AwdVN1?=
 =?utf-8?B?Rmloa2pTS1UyclZjUGYrdWFBZkxFT29hWkN1T201T1VPZXZRdUR6dmUrbGZ2?=
 =?utf-8?B?cUIveGsrQUNyVU1xVkFkdk1QOEUrTGN3MjNFc2YyRHd4YVQ3ak82TFJTamZI?=
 =?utf-8?B?RUZTT3ZZNTFuYXZlb1RkVnBRRDNnSVMvOWtMaE80K2ZFbHlrN3k3STR2bHNr?=
 =?utf-8?B?R3U0ajBKbm1wVXU4Sk5GOUJqYUpJRTlyeGp4Y1Zib3drZGtOVm5rSFYrYXNW?=
 =?utf-8?B?M0swR2VFWUxzdER0dFpjRG1jdkNqdEtOT1FPcHJLWlgyL0ZhenhZRDFVUmdY?=
 =?utf-8?B?UEdwRk0wdktyMDQvMFJZODQ5TDB0ZEUxNlh4T2xZNkdLK1R0UkkvMGs3Yk1l?=
 =?utf-8?B?cW9haXBSSHpwUEZvelVyNlJnb25RUHRxazhUZnNUZXloRXVqcVF2Mm5FSzVL?=
 =?utf-8?B?Y01WNjFqWXFwVHpQNlhpMEJndTg5ZFcyczZtRWF3Vm8ra3JVbm1abHVYWTZR?=
 =?utf-8?B?eXRibUszWklCRlFhU2dLVm1jbHVvR2ZFc3NpSy9HdjVjWmhLR1FVdEpweGEx?=
 =?utf-8?B?Nm1xYmdYQTZuYXJKc2JNclIyeWN6UFl6bzYyanI0THZqUDZ0OC9WZDJMUnBo?=
 =?utf-8?B?V29WcngwYnpjeXJsSUd2djBTU2JyRkF1OXdmL1gvdkE2UHZUeXNMUno2SXkx?=
 =?utf-8?Q?FXnZEnXidE1TPGKokjRKjnpSV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <78D368A1201E00499DC1572D3F753F45@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: G1+H/55VWegWXCTZ21SGm34YQseysoCuHdq/k4LkQB9DxyWQpmIK+Xmv4UKMCbkmpGya86ltuyeQS3PsEFq5Rx/cKqVDUO9Uki52susOEvQbfxnFoCkQr/4cpMesOaqV7mg6l9oeUOX4nM+lnTpTW82CJQL9SvAhCUOIvGhKAzrvoaGprZZ5ZryEYLqLnLoiBouelC80k2suevpdmTfbpCFEoSCsfKYvwkJKU9b5i3L30IFW1YaO//mqTplD1/6yxCXP8aiAu3gFEJ6cHBi0oP7zSA29BedD/AIcEs38U5xPLC+c5+blrP7mNsYTDU56BY6+j/wr7qbERLpPrD+5+i4RVD9M7Kesb5dGv0/rJM18GSpyOWW8k1wK6oykN5Qf5glfsiZU6+7cPCBL83b6MYMJBCiGLsqpfxHcvVJv1M2CPrlYUa5VItXQcbywbDUcm8VGXJchwR3qHC50cQnCgERyJyEebCieuefYrvvkY1TcMby904K6GZTTwIo6cLvJ4TcE0vnkmLaeINVn2KATxDzBRd/lYDBmkF9dQ4YLuZd39yJAmrFrI2JkrUi4Al+ILFOuAXng5QyRU6OVMKeDIjEf0N+LLIX/37UsbQB1nfWN/P2ZZWv4TdfUozjJDEDfyYzxJQ1ag/Z7rsSRBKez9LvNtNO8bfSRAM0FQQl3fNtGh13R6/iBBZqGpje0q3u5ddOQFxQDfaMakH7lRMik2YiGjVtBTLGA60cIjKfctaFSZnAOuBZCx5My0euUeWBlDK7GccQMphGU7zBvsBAxLpgM/x6L4dUvOkfYgpp8f8qYuF8ntVcLo6RVn8lYiCasVkbzfzFWEb7nBquMVaxBoU/M8Rne4AY4qVg2Sey2IQ/pxngBimaZCLa6AkoBj7kn8qFYCJ+v6LrlNA513pryOA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe2dcdf8-2dff-4669-c571-08db476c9f76
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2023 22:13:26.0063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w+sqI/ziRfPPvStYeRgfbvbgsNUbP4VfPxJuKnyz9UuKmr7hu2dQNU0qjE7mAh/h7rM52U+J9TgRZ1+vLuhqNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4951
X-Proofpoint-GUID: r1z8MV2O2Xx5dQp4SMe4y-seyfFGmMvu
X-Proofpoint-ORIG-GUID: r1z8MV2O2Xx5dQp4SMe4y-seyfFGmMvu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_09,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015 spamscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304270196
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBBcHIgMjcsIDIwMjMsIFJvZ2VyIFF1YWRyb3Mgd3JvdGU6DQo+IEhpLA0KPiANCj4g
T24gMjYvMDQvMjAyMyAyMzowMSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IEhpLA0KPiA+IA0K
PiA+IE9uIFdlZCwgQXByIDI2LCAyMDIzLCBSb2dlciBRdWFkcm9zIHdyb3RlOg0KPiA+PiBIaSBU
aGluaCwNCj4gPj4NCj4gPj4gT24gTGludXgga2VybmVsIHY2LjMNCj4gPj4gVGVzdCBwcm9jZWR1
cmU6IA0KPiA+Pg0KPiA+PiAtIG1vZHByb2JlIGdfemVybw0KPiA+PiAtIENvbm5lY3QgdG8gUEMg
aG9zdA0KPiA+PiAtIHN5c3RlbWN0bCBzdXNwZW5kDQo+ID4+DQo+ID4+IEEgbGFyZ2UgZGVsYXkg
b2YgMyBzZWNvbmRzIGlzIG9ic2VydmVkLiBUaGUgZGVsYXkgY29tZXMgZnJvbSBkd2MzX2dhZGdl
dF9zdXNwZW5kKCktPmR3YzNfZ2FkZ2V0X3J1bl9zdG9wKCkgd2FpdGluZyBmb3IgRFdDM19EU1RT
X0RFVkNUUkxITFQgdG8gYmUgc2V0Lg0KPiA+PiBJdCByZXR1cm5zIC1FVElNRURPVVQuDQo+ID4+
DQo+ID4+IEFyZSB3ZSBtaXNzaW5nIHNvbWV0aGluZyB0byBkbyBhIGNsZWFuIHN0b3AgZHVyaW5n
IHN1c3BlbmQ/DQo+ID4+DQo+ID4+IEZZSS4gVW5sb2FkaW5nIGdfemVybyBkb2VzIG5vdCBzaG93
IHRoaXMgZGVsYXkgb24gc3RvcC4NCj4gPj4NCj4gPj4gY2hlZXJzLA0KPiA+PiAtcm9nZXINCj4g
PiANCj4gPiBXaGVuIGNsZWFyaW5nIHJ1bl9zdG9wIGJpdCBhbmQgdGhlIGNvbnRyb2xsZXIgZG9l
c24ndCBoYWx0LCB0aGF0IHVzdWFsbHkNCj4gPiBtZWFucyB0aGVyZSBhcmUgYWN0aXZlIHRyYW5z
ZmVycy9lbmRwb2ludHMgdGhhdCBhcmVuJ3QgZW5kZWQgeWV0Lg0KPiA+IA0KPiA+IFRoZSBkd2Mz
X2dhZGdldF9zdXNwZW5kKCkgZG9lc24ndCBwcm9wZXJseSBkbyBhbGwgdGhlIGNsZWFudXAgYmVm
b3JlDQo+ID4gY2xlYXJpbmcgdGhlIHJ1bl9zdG9wIGJpdC4gSSB0aGluayB5b3UganVzdCBuZWVk
IHRvIGNhbGwNCj4gPiBkd2MzX2dhZGdldF9zb2Z0X2Rpc2Nvbm5lY3QoKSBpbiBkd2MzX2dhZGdl
dF9zdXNwZW5kKCkgdG8gZml4IHRoaXMuDQo+IA0KPiBUaGF0IHNlZW1zIHRvIGRvIHRoZSB0cmlj
ay4NCj4gSG93IGRvZXMgdGhpcyBsb29rPw0KPiANCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0gZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
PiBAQCAtNDY3NCwxMSArNDY3NiwxOCBAQCB2b2lkIGR3YzNfZ2FkZ2V0X2V4aXQoc3RydWN0IGR3
YzMgKmR3YykNCj4gIGludCBkd2MzX2dhZGdldF9zdXNwZW5kKHN0cnVjdCBkd2MzICpkd2MpDQo+
ICB7DQo+ICAJdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gKwlpbnQgcmV0Ow0KPiAgDQo+IC0JaWYg
KCFkd2MtPmdhZGdldF9kcml2ZXIpDQo+ICsJaWYgKCFkd2MtPmdhZGdldF9kcml2ZXIgfHwgIWR3
Yy0+c29mdGNvbm5lY3QpDQo+ICAJCXJldHVybiAwOw0KPiAgDQo+IC0JZHdjM19nYWRnZXRfcnVu
X3N0b3AoZHdjLCBmYWxzZSwgZmFsc2UpOw0KPiArCXJldCA9IGR3YzNfZ2FkZ2V0X3NvZnRfZGlz
Y29ubmVjdChkd2MpOw0KPiArCWlmIChyZXQpDQo+ICsJCWdvdG8gZXJyMDsNCj4gKw0KPiArCXJl
dCA9IGR3YzNfZ2FkZ2V0X3J1bl9zdG9wKGR3YywgZmFsc2UsIGZhbHNlKTsNCj4gKwlpZiAocmV0
KQ0KPiArCQlnb3RvIGVycjE7DQo+ICANCg0KV2UgYWxyZWFkeSBjbGVhciBydW5fc3RvcCBpbiBk
d2MzX2dhZGdldF9zb2Z0X2Rpc2Nvbm5lY3QoKS4NCg0KQ2FuIHlvdSB0cnkgdGhlIGZvbGxvd2lu
ZyBjaGFuZ2UgKG5vdCB0ZXN0ZWQpOg0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9n
YWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCmluZGV4IGMwY2E0ZDEyZjk1ZC4u
Mjk5NmJjYjRkNTNkIDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KKysr
IGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KQEAgLTI2OTksNiArMjY5OSwyMSBAQCBzdGF0
aWMgaW50IGR3YzNfZ2FkZ2V0X3NvZnRfZGlzY29ubmVjdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KIAly
ZXR1cm4gcmV0Ow0KIH0NCiANCitzdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X3NvZnRfY29ubmVjdChz
dHJ1Y3QgZHdjMyAqZHdjKQ0KK3sNCisJLyoNCisJICogSW4gdGhlIFN5bm9wc3lzIERXQ191c2Iz
MSAxLjkwYSBwcm9ncmFtbWluZyBndWlkZSBzZWN0aW9uDQorCSAqIDQuMS45LCBpdCBzcGVjaWZp
ZXMgdGhhdCBmb3IgYSByZWNvbm5lY3QgYWZ0ZXIgYQ0KKwkgKiBkZXZpY2UtaW5pdGlhdGVkIGRp
c2Nvbm5lY3QgcmVxdWlyZXMgYSBjb3JlIHNvZnQgcmVzZXQNCisJICogKERDVEwuQ1NmdFJzdCkg
YmVmb3JlIGVuYWJsaW5nIHRoZSBydW4vc3RvcCBiaXQuDQorCSAqLw0KKwlkd2MzX2NvcmVfc29m
dF9yZXNldChkd2MpOw0KKw0KKwlkd2MzX2V2ZW50X2J1ZmZlcnNfc2V0dXAoZHdjKTsNCisJX19k
d2MzX2dhZGdldF9zdGFydChkd2MpOw0KKwlyZXR1cm4gZHdjM19nYWRnZXRfcnVuX3N0b3AoZHdj
LCB0cnVlKTsNCit9DQorDQogc3RhdGljIGludCBkd2MzX2dhZGdldF9wdWxsdXAoc3RydWN0IHVz
Yl9nYWRnZXQgKmcsIGludCBpc19vbikNCiB7DQogCXN0cnVjdCBkd2MzCQkqZHdjID0gZ2FkZ2V0
X3RvX2R3YyhnKTsNCkBAIC0yNzM3LDIxICsyNzUyLDEwIEBAIHN0YXRpYyBpbnQgZHdjM19nYWRn
ZXRfcHVsbHVwKHN0cnVjdCB1c2JfZ2FkZ2V0ICpnLCBpbnQgaXNfb24pDQogDQogCXN5bmNocm9u
aXplX2lycShkd2MtPmlycV9nYWRnZXQpOw0KIA0KLQlpZiAoIWlzX29uKSB7DQorCWlmICghaXNf
b24pDQogCQlyZXQgPSBkd2MzX2dhZGdldF9zb2Z0X2Rpc2Nvbm5lY3QoZHdjKTsNCi0JfSBlbHNl
IHsNCi0JCS8qDQotCQkgKiBJbiB0aGUgU3lub3BzeXMgRFdDX3VzYjMxIDEuOTBhIHByb2dyYW1t
aW5nIGd1aWRlIHNlY3Rpb24NCi0JCSAqIDQuMS45LCBpdCBzcGVjaWZpZXMgdGhhdCBmb3IgYSBy
ZWNvbm5lY3QgYWZ0ZXIgYQ0KLQkJICogZGV2aWNlLWluaXRpYXRlZCBkaXNjb25uZWN0IHJlcXVp
cmVzIGEgY29yZSBzb2Z0IHJlc2V0DQotCQkgKiAoRENUTC5DU2Z0UnN0KSBiZWZvcmUgZW5hYmxp
bmcgdGhlIHJ1bi9zdG9wIGJpdC4NCi0JCSAqLw0KLQkJZHdjM19jb3JlX3NvZnRfcmVzZXQoZHdj
KTsNCi0NCi0JCWR3YzNfZXZlbnRfYnVmZmVyc19zZXR1cChkd2MpOw0KLQkJX19kd2MzX2dhZGdl
dF9zdGFydChkd2MpOw0KLQkJcmV0ID0gZHdjM19nYWRnZXRfcnVuX3N0b3AoZHdjLCB0cnVlKTsN
Ci0JfQ0KKwllbHNlDQorCQlyZXQgPSBkd2MzX2dhZGdldF9zb2Z0X2Nvbm5lY3QoZHdjKTsNCiAN
CiAJcG1fcnVudGltZV9wdXQoZHdjLT5kZXYpOw0KIA0KQEAgLTQ2NTUsNDIgKzQ2NTksMzkgQEAg
dm9pZCBkd2MzX2dhZGdldF9leGl0KHN0cnVjdCBkd2MzICpkd2MpDQogaW50IGR3YzNfZ2FkZ2V0
X3N1c3BlbmQoc3RydWN0IGR3YzMgKmR3YykNCiB7DQogCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQor
CWludCByZXQ7DQogDQogCWlmICghZHdjLT5nYWRnZXRfZHJpdmVyKQ0KIAkJcmV0dXJuIDA7DQog
DQotCWR3YzNfZ2FkZ2V0X3J1bl9zdG9wKGR3YywgZmFsc2UpOw0KKwlyZXQgPSBkd2MzX2dhZGdl
dF9zb2Z0X2Rpc2Nvbm5lY3QoZHdjKTsNCisJaWYgKHJldCkNCisJCWdvdG8gZXJyOw0KIA0KIAlz
cGluX2xvY2tfaXJxc2F2ZSgmZHdjLT5sb2NrLCBmbGFncyk7DQogCWR3YzNfZGlzY29ubmVjdF9n
YWRnZXQoZHdjKTsNCi0JX19kd2MzX2dhZGdldF9zdG9wKGR3Yyk7DQogCXNwaW5fdW5sb2NrX2ly
cXJlc3RvcmUoJmR3Yy0+bG9jaywgZmxhZ3MpOw0KIA0KIAlyZXR1cm4gMDsNCisNCitlcnI6DQor
CS8qDQorCSAqIEF0dGVtcHQgdG8gcmVzZXQgdGhlIGNvbnRyb2xsZXIncyBzdGF0ZS4gTGlrZWx5
IG5vDQorCSAqIGNvbW11bmljYXRpb24gY2FuIGJlIGVzdGFibGlzaGVkIHVudGlsIHRoZSBob3N0
DQorCSAqIHBlcmZvcm1zIGEgcG9ydCByZXNldC4NCisJICovDQorCWlmIChkd2MtPnNvZnRjb25u
ZWN0KQ0KKwkJZHdjM19nYWRnZXRfc29mdF9jb25uZWN0KGR3Yyk7DQorDQorCXJldHVybiByZXQ7
DQogfQ0KIA0KIGludCBkd2MzX2dhZGdldF9yZXN1bWUoc3RydWN0IGR3YzMgKmR3YykNCiB7DQot
CWludAkJCXJldDsNCi0NCiAJaWYgKCFkd2MtPmdhZGdldF9kcml2ZXIgfHwgIWR3Yy0+c29mdGNv
bm5lY3QpDQogCQlyZXR1cm4gMDsNCiANCi0JcmV0ID0gX19kd2MzX2dhZGdldF9zdGFydChkd2Mp
Ow0KLQlpZiAocmV0IDwgMCkNCi0JCWdvdG8gZXJyMDsNCi0NCi0JcmV0ID0gZHdjM19nYWRnZXRf
cnVuX3N0b3AoZHdjLCB0cnVlKTsNCi0JaWYgKHJldCA8IDApDQotCQlnb3RvIGVycjE7DQotDQot
CXJldHVybiAwOw0KLQ0KLWVycjE6DQotCV9fZHdjM19nYWRnZXRfc3RvcChkd2MpOw0KLQ0KLWVy
cjA6DQotCXJldHVybiByZXQ7DQorCXJldHVybiBkd2MzX2dhZGdldF9zb2Z0X2Nvbm5lY3QoZHdj
KTsNCiB9DQogDQogdm9pZCBkd2MzX2dhZGdldF9wcm9jZXNzX3BlbmRpbmdfZXZlbnRzKHN0cnVj
dCBkd2MzICpkd2MpDQoNCg0KDQotLQ0KDQpUaGFua3MsDQpUaGluaA==
