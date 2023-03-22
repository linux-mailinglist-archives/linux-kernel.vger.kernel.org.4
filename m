Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE366C5279
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjCVRcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCVRcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:32:19 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650695848B;
        Wed, 22 Mar 2023 10:32:18 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32MDRHak020432;
        Wed, 22 Mar 2023 10:32:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=ECd6q9iDRt+bPm3nZNc4eU3O9TneuxnBL7cJhzeOXPc=;
 b=deJv0WdMvC8qqx09WiGCmTRqDfMhr6QCIfrcVnckzZqhvMt273hVaH7P0h1scTURzJsy
 33IO302dgRFB8ZvN6RgYjACtISBvUfZtY2kK3B+kSOhaj7LE577YD0TxxxS/ZYxJB4WK
 Et6L4QjVajBV7T0ZZozTztSz6+7opWVA2GQrPFwhyrr6kQsszQhT2lZGL3oXlTQTGbx+
 owBESsysh8znQemwxswv9QIn9+wII/SMIeumzqqkqxxzQxKlHCw3CYpf+pJJ+avD2I8H
 lgdS+zrkXPnSi7wD5rWYYvm3EGyyRxP6skM0QY6MpQEunFTPU+896tVrxCgBRFuACbWA cA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3pdcj7d0ry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 10:32:03 -0700
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 17622C0447;
        Wed, 22 Mar 2023 17:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1679506322; bh=ECd6q9iDRt+bPm3nZNc4eU3O9TneuxnBL7cJhzeOXPc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=XAlk0CYu0/X5iNFNrId8zsRT6cVsi2aa5w70ugzD2ev/Fu+hg2Ms4YSAzfJl79LDk
         n/MbGSMdXFXLu1St2Y65xfeS7idLwjZ8EnSX0CNdGCHjCI05jRAvkFJh5AMQa/QZbx
         JVMePWi3KO4HY3+yWDPsCjQDX8csUQOBeyGnv0TkfEggTiLfX+JMPYA6IadDriQspi
         y3t1+KzU+EyOVW2vuE3Zm7cYcuTDb0buzO/9rXhjMswEaB+U8Zic3zXQ6PDXi8vOxe
         iMYmmgHwUZJRGSDt1WPPNqwYSsN+9vxxL4pNxTyKg/mGlp2fZRutbtKTyXOoD6ut4x
         hW5f0fgoYfjDg==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id D8EC3A0076;
        Wed, 22 Mar 2023 17:32:00 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2049.outbound.protection.outlook.com [104.47.57.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id B068E4011E;
        Wed, 22 Mar 2023 17:31:59 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="I+w391zo";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aB6GBVq2iM95SKLlaGWNhxOyKQT7QMr4L/d8OWfN9/25Xi8OlVMErxeQYIJQ4FwLW+nmXteqKlhQUq3dqumAYkc+lxo0fBHOFJm9y75voODoLlVnlDkf+zqyllk31us4DJtGi67r7RYPlpyErNijiJbTbRf5WqC3JUUdlOJXtRzU5hZ9h52ohBLeyyKlDZjXW25EIMieVz6AqmzHJxAPuRlg59zBbODFDUny01N2ywHNsWXroypLiujtKjyZGGKdNkMQULidXrEK6ubVxg6zyMpeUIM4s5wJOU2ziPSnEkdpbHpMOIY4hpGbAmA0yH2vNT+zag26Ryi5mZ0sD1lNSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECd6q9iDRt+bPm3nZNc4eU3O9TneuxnBL7cJhzeOXPc=;
 b=ZzM4vc4H+6QDCqVwMfCmZBL5VRnkpozecXJSE6lT45mO2ksXKs7cxbOFmsDSJ/LVUHRikZS48JAyt13Dyx06C0RIk4rvSCUZFWm8IING+A1xXOyvGLE5Jkp2sAf6FHCPuEtryoBQoGp8mp1mIfZhe+qpMtMUUH0fajOt2A1WSx+Ozxgob5BdtMLbypYSocHou+M3PsAfNRldANyMPct9GUdRXgCKMQ/sNnHBmwGvns9KGYkOIV4Iu1iPlCUOm04TBMLQiO3jI3hTrBix5xo/q81N8UVaMZwbf6H1iISSOuTg8QakZoApLNhiIli19k9QWUvELPwJcirOHFhUDNIAfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECd6q9iDRt+bPm3nZNc4eU3O9TneuxnBL7cJhzeOXPc=;
 b=I+w391zo0mxt1v3wNjwCf+41hDL/lYqI7DQRyaerlKShY+zTUuFWpUxGVp6L800OqWw/iwlhsZh4jOi4SikdX0UIb7xuw+fC9oW0ypWAZZ2jwe/WW+5f7xTt32kT3dXkQHY4OmFbqVq1VeK3JXY8M8lbh9C4n265nDGRSIoB4JY=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SJ1PR12MB6364.namprd12.prod.outlook.com (2603:10b6:a03:452::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 17:31:56 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 17:31:56 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Roger Quadros <rogerq@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "vigneshr@ti.com" <vigneshr@ti.com>, "srk@ti.com" <srk@ti.com>,
        "r-gunasekaran@ti.com" <r-gunasekaran@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/2] usb: dwc3: Support
 'snps,gadget-keep-connect-sys-sleep' feature
Thread-Topic: [RFC PATCH 2/2] usb: dwc3: Support
 'snps,gadget-keep-connect-sys-sleep' feature
Thread-Index: AQHZWw9BydGhQRYXjUGBS+C5GU6+168EBAMAgAEDRQCAAIy8AIAABewAgADbzQCAAJyDAA==
Date:   Wed, 22 Mar 2023 17:31:56 +0000
Message-ID: <20230322173150.nscqyzwcrecxjuaa@synopsys.com>
References: <20230320093447.32105-1-rogerq@kernel.org>
 <20230320093447.32105-3-rogerq@kernel.org>
 <20230320185206.a4o4bmhml7rlg6f7@synopsys.com>
 <48814d21-24d9-3141-68c8-316d071de1a8@kernel.org>
 <20230321184346.dxmqwq5rcsc2otrj@synopsys.com>
 <20230321190458.6uqlbtyfh3hc6ilg@synopsys.com>
 <7db7eb59-68fc-b7b2-5a29-00b698f68cbb@kernel.org>
In-Reply-To: <7db7eb59-68fc-b7b2-5a29-00b698f68cbb@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SJ1PR12MB6364:EE_
x-ms-office365-filtering-correlation-id: 74ab1c2e-26c2-4650-f25f-08db2afb5572
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hzjwdiQJXM3KW7VQGg2idTfB4WylMsXlCnRjA4duP61zcz8C7mzVclDyHDYr5zx/puw1sVh1cXmPiS8Zo0Lcicu8xZgccG7XeH+gj0bt7UdyTown3XdKubl0DeX51rbe2Km1PRtSwMB/D17soyE7ljLKLsf6EIMdMRio5rkDgJii5x+Twv9qSEjvH/eJ0xcAHpMgHWtMxfqQmahzms6bCM599jnt2LaBlqOZp0R3PLXn4UK2wt/t0hyOIuRWl6dqUdO8da2mCnA0Mhw7c12YpmSGJBF7NZ4thhrsKDx4pRgLPsTb5A9Wv2XEEbbs6M4kIpzcE/XHUFyj2XUjBNf539KrQfxNBNBzE2Vouj7VbetgGXNvJeOH9S9sYWns8C6c1JufvnGV5KVoIZVmeBXikAqHKGO0bZXoTKdMCt6dKU/pgCPLVytzTT/Cb5N148982Ty6IrWD8oiWU+s+AJF8e5nhsC/nVsSRMwDZhz4m6MAqLTVO2bDKZGRl9nYtrDunKwlsxFZPNSOOoN7cD/LVC+0I/NNdQRk/RaEYlfH+mT4MwgIqh8l941v9HXW/uRw1Rqzh0BDedeBcgRfu2SPu56x0AiUTA6Ab4a0imRUNAZ6q3l78RBYKXGIHTO+rG0PTwduWReCLmYVm2EHRCG5La4mgX/WxbRJN+iur779eNr2rQYAm26kp4m5Xkk1IiFDXulQXWFNImPXG3hQU+bbeJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(376002)(136003)(366004)(346002)(451199018)(38100700002)(66946007)(41300700001)(6916009)(66476007)(4326008)(64756008)(3716004)(8676002)(76116006)(66446008)(66556008)(2906002)(36756003)(8936002)(122000001)(6512007)(6506007)(1076003)(53546011)(6486002)(38070700005)(71200400001)(26005)(478600001)(86362001)(2616005)(5660300002)(83380400001)(316002)(186003)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzNkazhRa3dkMFVpTkJNdmhVTktKblJab0FPcHV2L0VLNCtKYU9ITll0TVhz?=
 =?utf-8?B?T0t2YUl4MXh3NnhJTU9icDllOWsrdjFsZG5nWkpxNmdoaWtxM3NQdGhxVW0v?=
 =?utf-8?B?bHVpSnk5YTFhNVJOcmhmQktmWmZtU1FxNzVPaTNUMDFUcWYyM1VFaGh6dGV5?=
 =?utf-8?B?MGl4emZYOEtFMWNwTlQ3QVh1L2Z6c3pNRmF4bTAzZGFSUDVOV2dmRXkyVkhv?=
 =?utf-8?B?TmEwbTV5RXJGQnRTdEs1WVhDRzNQTldNK2daNTRlSTFjWlZJRkFOTWNaeHhu?=
 =?utf-8?B?RURJMnZwM2FkM0VtYjhObVBRTW5oK3AwZzJjNUZtMnh4TjlQV0E2aUVHNzBC?=
 =?utf-8?B?MGhZN0tKMENpSmpXR3V3aUF3cHh1a1ZjelljQzRFVU1pYU1qYThWSmlWSFcw?=
 =?utf-8?B?Ukk0a3pVRmlwZURDZlQ4Y0JVRnpxWFcxSjRNUHluWCtHSHdDa1hnV1JkMlc3?=
 =?utf-8?B?Z1dSZjQ5bit0WjlxK3g4OHdjdzVWTGxUSXd5eDZ0aTBZRDJ2S2tMMW4ycHBt?=
 =?utf-8?B?czlhOVFYUWVNS1dRbUFUemRHQUpJeVE2UEFrRi9MVkFKeGRBUDVtUjFXcjZV?=
 =?utf-8?B?SXVSWXljWEZWT3lYakNFUEtRZlpNZHMwamJMMmpBWm5ucXRvZjZqd1doYXA4?=
 =?utf-8?B?WXFxazY2NVBZSktzMVo2a1drbTFlamd1aWJRZXAwMUo2cDV6bDkxT2lDVldq?=
 =?utf-8?B?VHMxbjZOT3lYY2N4ekp3dWFkMGpKejMvQm5LZWlrV2UxcEZZMlFIU0NWOXRC?=
 =?utf-8?B?bktwTEpTZk9jYldGNTZVcnNOTnovbGM4eGpYY2Vka3Naa2I0blc1eDV5K0xp?=
 =?utf-8?B?RVdUUDMxQVExYnhZdXZURlZBV25SSnVkcWtvcEE4SkRXR1ZOL3E1ejJIaU4v?=
 =?utf-8?B?WGk2bnFFSm1pV1FxWVFpWDEyZmVOekRuL25yN1VsQnY4YWhNaXhsRVVFOG5L?=
 =?utf-8?B?M3FGaG53aGJpMTdheCs1RThnTTJJcnpBdkZtYklQOFVSTi91VCtKMG1nRUN0?=
 =?utf-8?B?NjBUWjQ4dmV5OU9yNGIvSloyL3hiN3cvVktYZFd5Njd5cVd1bzJZNjlab2gw?=
 =?utf-8?B?Y0RVSWtNT3RMSmNucVQ4ZUlnazkzOVFVNzkzNHNxdkJVV2xLSmEvdXNFelI4?=
 =?utf-8?B?aEY1NUpFNndyK1VMRy9Lckx0azNINCtRYzNFUldGYyt0S0wxVXpDMFZFM1hN?=
 =?utf-8?B?enZrZ3lyWWtlMjVqd0t2RzUwbDFvQTM4UC90UUg0OFhjNjJmcGZJS2NRMlVD?=
 =?utf-8?B?ZFJ6a21kYy93NUlzNFRCUnpoTUVJSVZoSFdOaFVjaFBON3NieGo1b2llbzZN?=
 =?utf-8?B?aEx2cWw4UjJXeUxMbGgxMENwZ2g0K08rRjgwVFdJYWJaNUs2dHp1V0huUUlh?=
 =?utf-8?B?VW54RlNKRlozaHZiaE42ejRkbkRML2t3UnJuM2R1c01pQlRwSFJiVHJOa1M2?=
 =?utf-8?B?OXp1YUJTcVBBZHVKTFFHcjhQMUVyaGMrc2paeWZpbmVURXdVV2hQeFdncGRE?=
 =?utf-8?B?ZEFjSllWWm1CSGE4QXE0SU5vWm1ja2lualdoMnlKUmw2aXlpQTJ3c0RmRGF2?=
 =?utf-8?B?L0dpK0RINnNCZjEwcWd3bTZXcisyaUIwNnVPQ3ZqSy9KcFBIREVRcXhYT3Y3?=
 =?utf-8?B?WmJYTVV1ckFuYzJucjExWUtWU2J0dTFKamVpd1JQcTA5bm1mMFE0ZTJtZE5w?=
 =?utf-8?B?VzVENjBndENuSUFuMHRvY25FN3E0bjVJb2NwYVA3ZG0vTGtyQVlpWHNEeHF4?=
 =?utf-8?B?K3Q4d0Vnb25Hb2EwN0NCZGt1OWZLU3c2aXRqYnd1L2k4dUhCaFlldVFBUXli?=
 =?utf-8?B?bWU3clNtRlpDRnRodk5ja05tdjJ5SU1xUGJkdnIxSXdvMXRXSHpIQlQybzVr?=
 =?utf-8?B?VVJmRExWQSsrSmxSVUtDRjczVGI4Vk5kOFpUM2MvNUh0TGw5eTdTQi8wa2R6?=
 =?utf-8?B?cjhNckZhUlNhc0Rlb2hsUGpVWW1NWmMwMW1DNWYvY1I1eHYzdFlxNWtoTFVE?=
 =?utf-8?B?alVnZjdsbDJYSDk2aE00TlRpNFlqMHNFV3k3Sk16TzZtZEFZUXRyeStoUWFs?=
 =?utf-8?B?a01yKzBXYm5kVTg0YmJibGZxUzg0Rk1wZVM4bWpJdENNWThFUjd4WW9rWmc5?=
 =?utf-8?Q?MtQKaCWLAtlaaFny9+J91rHUU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <48C9B110F675DC4498D2EC0C3C405D2D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?V0daMThVdFpGWE9rY3ZTK3VCc0VJc29OSUZWY2wzWjJKbk9GTW9mVk91Umlh?=
 =?utf-8?B?amFkSm1kOXdIdURuT2NDUXhVUWxxRFFpUVpwZ3d5enVWVFQ5RTBTNmlQRDlk?=
 =?utf-8?B?N21zMk9UeXpadUlSNzMzOEUxQTk0OERxcE5yOVpTSWNnT3BSa2laTkJUdEdv?=
 =?utf-8?B?bkg2UlM0UWlxa1hQQTZpbHdUTmdubWtkWi9GaFJTYTkwdDNPLzJqZytWemhi?=
 =?utf-8?B?dmNyZXB1SWVNUlVveVYvMDFCcmFDWGF3VVFTYXZsN0tNRTU3RDhxaU45OXd5?=
 =?utf-8?B?Vi8wZHZzL0RFaGd1NG03MFZBVXJLZVhQNGxtZXd0bmNkNnkrUDJpZ2NjUzBE?=
 =?utf-8?B?bnY4OGJYaWZURHdmc3RiSFUwUmh2Yk5JOHZ6SGdNTXF4UUxMaGJKL0p3Und3?=
 =?utf-8?B?NVF0S083QWNka3dxbysvU3FUQTdjbVVqcDc3cEVtNExRbS9vZUVpLzJ1dGtV?=
 =?utf-8?B?M2ZQQnplU282Qi9JNGtzekxjZWpuZWl1akVIZkRTMEpQdzF5SkhnbTJUcUZu?=
 =?utf-8?B?WGcwSm5LYURRZ0c0MlQwdWdNNzZ3blVGM1plamZoNlVMZFI2VTJ6dHVPUXVK?=
 =?utf-8?B?RzJON0pwNmROQWVtZG5zdUQxTkJYcmlsaThGaWp6RHIvdVdxbjNCcG9sd0NE?=
 =?utf-8?B?cFBOMlQ0blNTTDlpZEgxNVdkVE4rLytDZk9ZQytFWTBPM0J4WG1yaXljRDA5?=
 =?utf-8?B?ZHVSYzZ4S05oUjZLM2lzb0pPSFdrWVl4Wmk0amVtcE5jTmFCWGg3YU8xdXN4?=
 =?utf-8?B?T1lBb3dzRUkwOERCQWFFUmtaa2JNM01PUHZ2MEhUZ0FDeTlWMmo3S0VSNlhp?=
 =?utf-8?B?N0xBUUJndnA3YkcyYU5MSmNaQXhJTnQ2YkNuWlBmSVJSUEhnQUJ0Q3hzZnFj?=
 =?utf-8?B?OXRHdU1kMWdydDRESWw0cGJKK2VsN3M0VUhzT2dIaG8yL04zRXZQMkEvTFp1?=
 =?utf-8?B?aWdWRkFrbGdxU2JGc05FQll2RWg1NTN2dWNibWV1MjJJUTd4YTI3R1VtSVpM?=
 =?utf-8?B?UTcyOEdvcG5QS1RWNkpTWG1mR2JNYnp1K3FrckdQbzAyN2NESzlKUFd4QnFi?=
 =?utf-8?B?Z2plZzJHallwcHFVZCtmZnBrVUdJUm13Ykh1VkRSNDJmQVYwMkl2aHdMV054?=
 =?utf-8?B?VzJrdkdzcExuT1dTaFo3a21KUHVEcTRtRjlwRFR3dnZGVEc4dHE1elF0cUdT?=
 =?utf-8?B?UUFSaXpqbnZtdVFMVVlnZXlseEp2T291akJJNkZ4TmVaSXV4cVBrRmdZTE01?=
 =?utf-8?B?b05QOWZLNFVkNVZjWXErdTcrcGZ3dTYvbWFuUXFtY0s3TEF1Zz09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ab1c2e-26c2-4650-f25f-08db2afb5572
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 17:31:56.1342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GOfcrsiNZagBIq2O7jJyJW/+e0uHLBuJ77ZWKRTTQvkbuNQ8eWw1GQ+6SxfEvHLH6kmhnTJUZyfA5moBeHY47Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6364
X-Proofpoint-GUID: z_MSLc4grtc-OQfvrM7CO8m0ZOD7yRIr
X-Proofpoint-ORIG-GUID: z_MSLc4grtc-OQfvrM7CO8m0ZOD7yRIr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_14,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 mlxscore=0 spamscore=0 clxscore=1015 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303220123
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBNYXIgMjIsIDIwMjMsIFJvZ2VyIFF1YWRyb3Mgd3JvdGU6DQo+IE9uIDIxLzAzLzIw
MjMgMjE6MDUsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBPbiBUdWUsIE1hciAyMSwgMjAyMywg
VGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+PiBPbiBUdWUsIE1hciAyMSwgMjAyMywgUm9nZXIgUXVh
ZHJvcyB3cm90ZToNCj4gPj4+IEhpIFRoaW5oLA0KPiA+Pj4NCj4gPj4+IE9uIDIwLzAzLzIwMjMg
MjA6NTIsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPj4+PiBIaSwNCj4gPj4+Pg0KPiA+Pj4+IE9u
IE1vbiwgTWFyIDIwLCAyMDIzLCBSb2dlciBRdWFkcm9zIHdyb3RlOg0KPiA+Pj4+PiBJbXBsZW1l
bnQgJ3NucHMsZ2FkZ2V0LWtlZXAtY29ubmVjdC1zeXMtc2xlZXAnIHByb3BlcnR5Lg0KPiA+Pj4+
Pg0KPiA+Pj4+PiBEbyBub3Qgc3RvcCB0aGUgZ2FkZ2V0IGNvbnRyb2xsZXIgYW5kIGRpc2Nvbm5l
Y3QgaWYgdGhpcw0KPiA+Pj4+PiBwcm9wZXJ0eSBpcyBwcmVzZW50IGFuZCB3ZSBhcmUgY29ubmVj
dGVkIHRvIGEgVVNCIEhvc3QuDQo+ID4+Pj4+DQo+ID4+Pj4+IFByZXZlbnQgU3lzdGVtIHNsZWVw
IGlmIEdhZGdldCBpcyBub3QgaW4gVVNCIHN1c3BlbmQuDQo+ID4+Pj4+DQo+ID4+Pj4+IFNpZ25l
ZC1vZmYtYnk6IFJvZ2VyIFF1YWRyb3MgPHJvZ2VycUBrZXJuZWwub3JnPg0KPiA+Pj4+PiAtLS0N
Cj4gPj4+Pj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jICAgfCAyNSArKysrKysrKysrKysrKysr
KysrLS0tLS0tDQo+ID4+Pj4+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCAgIHwgIDIgKysNCj4g
Pj4+Pj4gIGRyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgfCAyNSArKysrKysrKysrKysrKysrKysr
KysrKy0tDQo+ID4+Pj4+ICAzIGZpbGVzIGNoYW5nZWQsIDQ0IGluc2VydGlvbnMoKyksIDggZGVs
ZXRpb25zKC0pDQo+ID4+Pj4+DQo+ID4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2Mz
L2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ID4+Pj4+IGluZGV4IDQ3NmI2MzYx
ODUxMS4uYTQ3YmJhYTI3MzAyIDEwMDY0NA0KPiA+Pj4+PiAtLS0gYS9kcml2ZXJzL3VzYi9kd2Mz
L2NvcmUuYw0KPiA+Pj4+PiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+Pj4+PiBA
QCAtMTU3NSw2ICsxNTc1LDkgQEAgc3RhdGljIHZvaWQgZHdjM19nZXRfcHJvcGVydGllcyhzdHJ1
Y3QgZHdjMyAqZHdjKQ0KPiA+Pj4+PiAgCWR3Yy0+ZGlzX3NwbGl0X3F1aXJrID0gZGV2aWNlX3By
b3BlcnR5X3JlYWRfYm9vbChkZXYsDQo+ID4+Pj4+ICAJCQkJInNucHMsZGlzLXNwbGl0LXF1aXJr
Iik7DQo+ID4+Pj4+ICANCj4gPj4+Pj4gKwlkd2MtPmdhZGdldF9rZWVwX2Nvbm5lY3Rfc3lzX3Ns
ZWVwID0gZGV2aWNlX3Byb3BlcnR5X3JlYWRfYm9vbChkZXYsDQo+ID4+Pj4+ICsJCQkJInNucHMs
Z2FkZ2V0LWtlZXAtY29ubmVjdC1zeXMtc2xlZXAiKTsNCj4gPj4+Pj4gKw0KPiA+Pj4+PiAgCWR3
Yy0+bHBtX255ZXRfdGhyZXNob2xkID0gbHBtX255ZXRfdGhyZXNob2xkOw0KPiA+Pj4+PiAgCWR3
Yy0+dHhfZGVfZW1waGFzaXMgPSB0eF9kZV9lbXBoYXNpczsNCj4gPj4+Pj4gIA0KPiA+Pj4+PiBA
QCAtMjAyNywxNCArMjAzMCwyMCBAQCBzdGF0aWMgaW50IGR3YzNfc3VzcGVuZF9jb21tb24oc3Ry
dWN0IGR3YzMgKmR3YywgcG1fbWVzc2FnZV90IG1zZykNCj4gPj4+Pj4gIHsNCj4gPj4+Pj4gIAl1
bnNpZ25lZCBsb25nCWZsYWdzOw0KPiA+Pj4+PiAgCXUzMiByZWc7DQo+ID4+Pj4+ICsJaW50IHJl
dDsNCj4gPj4+Pj4gIA0KPiA+Pj4+PiAgCXN3aXRjaCAoZHdjLT5jdXJyZW50X2RyX3JvbGUpIHsN
Cj4gPj4+Pj4gIAljYXNlIERXQzNfR0NUTF9QUlRDQVBfREVWSUNFOg0KPiA+Pj4+PiAgCQlpZiAo
cG1fcnVudGltZV9zdXNwZW5kZWQoZHdjLT5kZXYpKQ0KPiA+Pj4+PiAgCQkJYnJlYWs7DQo+ID4+
Pj4+IC0JCWR3YzNfZ2FkZ2V0X3N1c3BlbmQoZHdjKTsNCj4gPj4+Pj4gKwkJcmV0ID0gZHdjM19n
YWRnZXRfc3VzcGVuZChkd2MpOw0KPiA+Pj4+PiArCQlpZiAocmV0KSB7DQo+ID4+Pj4+ICsJCQlk
ZXZfZXJyKGR3Yy0+ZGV2LCAiZ2FkZ2V0IG5vdCBzdXNwZW5kZWQ6ICVkXG4iLCByZXQpOw0KPiA+
Pj4+PiArCQkJcmV0dXJuIHJldDsNCj4gPj4+Pj4gKwkJfQ0KPiA+Pj4+PiAgCQlzeW5jaHJvbml6
ZV9pcnEoZHdjLT5pcnFfZ2FkZ2V0KTsNCj4gPj4+Pj4gLQkJZHdjM19jb3JlX2V4aXQoZHdjKTsN
Cj4gPj4+Pj4gKwkJaWYoIWR3Yy0+Z2FkZ2V0X2tlZXBfY29ubmVjdF9zeXNfc2xlZXApDQo+ID4+
Pj4+ICsJCQlkd2MzX2NvcmVfZXhpdChkd2MpOw0KPiA+Pj4+PiAgCQlicmVhazsNCj4gPj4+Pj4g
IAljYXNlIERXQzNfR0NUTF9QUlRDQVBfSE9TVDoNCj4gPj4+Pj4gIAkJaWYgKCFQTVNHX0lTX0FV
VE8obXNnKSAmJiAhZGV2aWNlX21heV93YWtldXAoZHdjLT5kZXYpKSB7DQo+ID4+Pj4+IEBAIC0y
MDg4LDExICsyMDk3LDE1IEBAIHN0YXRpYyBpbnQgZHdjM19yZXN1bWVfY29tbW9uKHN0cnVjdCBk
d2MzICpkd2MsIHBtX21lc3NhZ2VfdCBtc2cpDQo+ID4+Pj4+ICANCj4gPj4+Pj4gIAlzd2l0Y2gg
KGR3Yy0+Y3VycmVudF9kcl9yb2xlKSB7DQo+ID4+Pj4+ICAJY2FzZSBEV0MzX0dDVExfUFJUQ0FQ
X0RFVklDRToNCj4gPj4+Pj4gLQkJcmV0ID0gZHdjM19jb3JlX2luaXRfZm9yX3Jlc3VtZShkd2Mp
Ow0KPiA+Pj4+PiAtCQlpZiAocmV0KQ0KPiA+Pj4+PiAtCQkJcmV0dXJuIHJldDsNCj4gPj4+Pj4g
KwkJaWYgKCFkd2MtPmdhZGdldF9rZWVwX2Nvbm5lY3Rfc3lzX3NsZWVwKQ0KPiA+Pj4+PiArCQl7
DQo+ID4+Pj4+ICsJCQlyZXQgPSBkd2MzX2NvcmVfaW5pdF9mb3JfcmVzdW1lKGR3Yyk7DQo+ID4+
Pj4+ICsJCQlpZiAocmV0KQ0KPiA+Pj4+PiArCQkJCXJldHVybiByZXQ7DQo+ID4+Pj4+ICsNCj4g
Pj4+Pj4gKwkJCWR3YzNfc2V0X3BydGNhcChkd2MsIERXQzNfR0NUTF9QUlRDQVBfREVWSUNFKTsN
Cj4gPj4+Pj4gKwkJfQ0KPiA+Pj4+PiAgDQo+ID4+Pj4+IC0JCWR3YzNfc2V0X3BydGNhcChkd2Ms
IERXQzNfR0NUTF9QUlRDQVBfREVWSUNFKTsNCj4gPj4+Pj4gIAkJZHdjM19nYWRnZXRfcmVzdW1l
KGR3Yyk7DQo+ID4+Pj4+ICAJCWJyZWFrOw0KPiA+Pj4+PiAgCWNhc2UgRFdDM19HQ1RMX1BSVENB
UF9IT1NUOg0KPiA+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmggYi9k
cml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiA+Pj4+PiBpbmRleCA1ODJlYmQ5Y2Y5YzIuLmY4NGJh
YzgxNWJlZCAxMDA2NDQNCj4gPj4+Pj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4g
Pj4+Pj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gPj4+Pj4gQEAgLTEzMjgsNiAr
MTMyOCw4IEBAIHN0cnVjdCBkd2MzIHsNCj4gPj4+Pj4gIAl1bnNpZ25lZAkJZGlzX3NwbGl0X3F1
aXJrOjE7DQo+ID4+Pj4+ICAJdW5zaWduZWQJCWFzeW5jX2NhbGxiYWNrczoxOw0KPiA+Pj4+PiAg
DQo+ID4+Pj4+ICsJdW5zaWduZWQJCWdhZGdldF9rZWVwX2Nvbm5lY3Rfc3lzX3NsZWVwOjE7DQo+
ID4+Pj4+ICsNCj4gPj4+Pj4gIAl1MTYJCQlpbW9kX2ludGVydmFsOw0KPiA+Pj4+PiAgDQo+ID4+
Pj4+ICAJaW50CQkJbWF4X2NmZ19lcHM7DQo+ID4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Vz
Yi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiA+Pj4+PiBpbmRl
eCAzYzYzZmE5N2E2ODAuLjgwNjJlNDRmNjNmNiAxMDA2NDQNCj4gPj4+Pj4gLS0tIGEvZHJpdmVy
cy91c2IvZHdjMy9nYWRnZXQuYw0KPiA+Pj4+PiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdl
dC5jDQo+ID4+Pj4+IEBAIC00NTcyLDEyICs0NTcyLDIzIEBAIHZvaWQgZHdjM19nYWRnZXRfZXhp
dChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiA+Pj4+PiAgaW50IGR3YzNfZ2FkZ2V0X3N1c3BlbmQoc3Ry
dWN0IGR3YzMgKmR3YykNCj4gPj4+Pj4gIHsNCj4gPj4+Pj4gIAl1bnNpZ25lZCBsb25nIGZsYWdz
Ow0KPiA+Pj4+PiArCWludCBsaW5rX3N0YXRlOw0KPiA+Pj4+PiAgDQo+ID4+Pj4+ICAJaWYgKCFk
d2MtPmdhZGdldF9kcml2ZXIpDQo+ID4+Pj4+ICAJCXJldHVybiAwOw0KPiA+Pj4+PiAgDQo+ID4+
Pj4+IC0JZHdjM19nYWRnZXRfcnVuX3N0b3AoZHdjLCBmYWxzZSwgZmFsc2UpOw0KPiA+Pj4+PiAr
CWlmIChkd2MtPmdhZGdldF9rZWVwX2Nvbm5lY3Rfc3lzX3NsZWVwICYmIGR3Yy0+Y29ubmVjdGVk
KSB7DQo+ID4+Pj4+ICsJCWxpbmtfc3RhdGUgPSBkd2MzX2dhZGdldF9nZXRfbGlua19zdGF0ZShk
d2MpOw0KPiA+Pj4+PiArCQkvKiBQcmV2ZW50IFBNIFNsZWVwIGlmIG5vdCBpbiBVMy9MMiAqLw0K
PiA+Pj4+PiArCQlpZiAobGlua19zdGF0ZSAhPSBEV0MzX0xJTktfU1RBVEVfVTMpDQo+ID4+Pj4+
ICsJCQlyZXR1cm4gLUVCVVNZOw0KPiA+Pj4+PiArDQo+ID4+Pj4+ICsJCS8qIGRvbid0IHN0b3Av
ZGlzY29ubmVjdCAqLw0KPiA+Pj4+PiArCQlkd2MzX2dhZGdldF9kaXNhYmxlX2lycShkd2MpOw0K
PiA+Pj4+DQo+ID4+Pj4gV2Ugc2hvdWxkbid0IGRpc2FibGUgZXZlbnQgaW50ZXJydXB0IGhlcmUu
IFdoYXQgd2lsbCBoYXBwZW4gaWYgdGhlDQo+ID4+Pg0KPiA+Pj4gRHVlIHRvIHNvbWUgcmVhc29u
LCBpZiBJIGRvbid0IGRpc2FibGUgdGhlIGV2ZW50IGludGVycnVwdHMgaGVyZSB0aGVuDQo+ID4+
PiBhZnRlciBVU0IgcmVzdW1lIHRoZSBVU0IgY29udHJvbGxlciBpcyBtYWxmdW5jdGlvbmluZy4N
Cj4gPj4+IEl0IG5vIGxvbmdlciByZXNwb25kcyB0byBhbnkgcmVxdWVzdHMgZnJvbSBIb3N0Lg0K
PiA+Pg0KPiA+PiBZb3Ugc2hvdWxkIGxvb2sgaW50byB0aGlzLiBUaGVzZSBldmVudHMgYXJlIGlt
cG9ydGFudCBhcyB0aGV5IGNhbiB0ZWxsDQo+ID4+IHdoZXRoZXIgdGhlIGhvc3QgaW5pdGlhdGVz
IHJlc3VtZS4NCj4gPj4NCj4gPj4+DQo+ID4+Pj4gZGV2aWNlIGlzIGRpc2Nvbm5lY3RlZCBhbmQg
cmVjb25uZWN0IHRvIHRoZSBob3N0IHdoaWxlIHRoZSBkZXZpY2UgaXMNCj4gPj4+PiBzdGlsbCBp
biBzeXN0ZW0gc3VzcGVuZD8gVGhlIGhvc3Qgd291bGQgbm90IGJlIGFibGUgdG8gY29tbXVuaWNh
dGUgd2l0aA0KPiA+Pj4+IHRoZSBkZXZpY2UgdGhlbi4NCj4gPj4+DQo+ID4+PiBJbiB0aGUgVEkg
cGxhdGZvcm0sIFRoZSBzeXN0ZW0gaXMgd29rZW4gdXAgb24gYW55IFZCVVMvbGluZXN0YXRlIGNo
YW5nZQ0KPiA+Pj4gYW5kIGluIGR3YzNfZ2FkZ2V0X3Jlc3VtZSB3ZSBlbmFibGUgdGhlIGV2ZW50
cyBhZ2FpbiBhbmQgY2hlY2sgZm9yIHBlbmRpbmcNCj4gPj4+IGV2ZW50cy4gSXMgaXQgcG9pbnRs
ZXNzIHRvIGNoZWNrIGZvciBwZW5kaW5nIGV2ZW50cyB0aGVyZT8NCj4gPj4+DQo+ID4+DQo+ID4+
IEl0IHNlZW1zIGZyYWdpbGUgZm9yIHRoZSBpbXBsZW1lbnRhdGlvbiB0byBiZSBkZXBlbmRlbnQg
b24gcGxhdGZvcm0NCj4gPj4gc3BlY2lmaWMgZmVhdHVyZSByaWdodD8NCj4gPj4NCj4gPj4gQWxz
bywgd2hhdCB3aWxsIGhhcHBlbiBpbiBhIHR5cGljYWwgY2FzZSB3aGVuIHRoZSBob3N0IHB1dHMg
dGhlIGRldmljZQ0KPiA+PiBpbiBzdXNwZW5kIGFuZCBpbml0aWF0ZXMgcmVzdW1lIHdoaWxlIHRo
ZSBkZXZpY2UgaXMgaW4gc3lzdGVtIHN1c3BlbmQNCj4gPj4gKGFuZCBzdGF5IGluIHN1c3BlbmQg
b3ZlciBhIHBlcmlvZCBvZiB0aW1lKT8gVGhlcmUgaXMgbm8gVkJVUyBjaGFuZ2UuDQo+ID4+IFRo
ZXJlIHdpbGwgYmUgcHJvYmxlbSBpZiBob3N0IGRldGVjdHMgbm8gcmVzcG9uc2UgZnJvbSBkZXZp
Y2UgaW4gdGltZS4NCj4gPj4NCj4gPj4gRG9uJ3Qgd2UgbmVlZCB0aGVzZSBldmVudHMgdG8gd2Fr
ZXVwIHRoZSBkZXZpY2U/DQo+IA0KPiBUaGF0J3Mgd2h5IHRoZSBUSSBpbXBsZW1lbnRhdGlvbiBo
YXMgbGluZS1zdGF0ZSBjaGFuZ2UgZGV0ZWN0aW9uIHRvDQo+IGRldGVjdCBhIFVTQiByZXN1bWUu
IFdlIGFyZSBkb2luZyBhIG91dC1vZi1iYW5kIHdha2UtdXAuIFRoZSB3YWtlIHVwDQo+IGV2ZW50
cyBhcmUgY29uZmlndXJlZCBpbiB0aGUgd3JhcHBlciBkcml2ZXIgKGR3YzMtYW02Mi5jKS4NCj4g
DQo+IERvIHlvdSBrbm93IG9mIGFueSBkd2MzIGltcGxlbWVudGF0aW9uIHRoYXQgdXNlcyBpbi1i
YW5kIG1lY2hhbmlzbQ0KPiB0byB3YWtlIHVwIHRoZSBTeXN0ZW0uIGkuZS4gaXQgcmVsaWVzIG9u
IGV2ZW50cyBlbmFibGVkIGluIERFVlRFTiByZWdpc3Rlcj8NCj4gDQoNCldlIHJlbHkgb24gUE1F
LiBUaGUgUE1FIGlzIGdlbmVyYXRlZCBmcm9tIHRoZSBQTVUgb2YgdGhlIHVzYiBjb250cm9sbGVy
DQp3aGVuIGl0IGRldGVjdHMgYSByZXN1bWUuIElmIHlvdXIgcGxhdGZvcm0gc3VwcG9ydHMgaGli
ZXJuYXRpb24gYW5kIGlmDQp0aGUgcmVzdW1lIHNpZ25hbCBpcyBjb25uZWN0ZWQgdG8gdGhlIGxv
d2VyIGxheWVyIHBvd2VyIG1hbmFnZXIgb2YgeW91cg0KZGV2aWNlLCB0aGVuIHlvdSBjYW4gd2Fr
ZXVwIHRoZSBzeXN0ZW0gb25lIGxldmVsIGF0IGEgdGltZS4gRm9yIGV4YW1wbGUsDQppZiB5b3Vy
IGRldmljZSBpcyBhIHBjaSBkZXZpY2UsIHRoYXQgd2FrZXVwIHNpZ25hbCB3b3VsZCB0aWUgdG8g
dGhlIHBjaQ0KcG93ZXIgbWFuYWdlciwgd2FraW5nIHVwIHRoZSBwY2kgbGF5ZXIgYmVmb3JlIHdh
a2luZyB1cCB0aGUgY29yZSBvZiB0aGUNCnVzYiBjb250cm9sbGVyLiBUaGF0J3MgaG93IHRoZSBo
b3N0IHdha2VzIHVwIHRoZSBob3N0IHN5c3RlbSAoZS5nLiBmcm9tDQpyZW1vdGUgd2FrZXVwKS4g
Rm9yIHRoaXMgdG8gd29yaywgd2UgZXhwZWN0IHNvbWV0aGluZyBzaW1pbGFyIG9uIHRoZQ0KZGV2
aWNlIHNpZGUuDQoNCj4gPj4NCj4gPiANCj4gPiBXZSBtYXkgbm90IGJlIGFibGUgdG8gc3VzcGVu
ZCBldmVyeXRoaW5nIGluIHN5c3RlbSBzdXNwZW5kIGZvciB0aGlzDQo+ID4gY2FzZS4gSSdtIHRo
aW5raW5nIG9mIHRyZWF0aW5nIHRoZXNlIGV2ZW50cyBhcyBpZiB0aGV5IGFyZSBQTUUgdG8gd2Fr
ZXVwDQo+ID4gdGhlIGRldmljZSwgYnV0IHRoZXkgYXJlIG5vdCB0aGUgc2FtZS4gSXQgbWF5IG5v
dCBiZSBzaW1wbGUgdG8gaGFuZGxlDQo+ID4gdGhpcy4gVGhlIGxvd2VyIGxheWVycyBtYXkgbmVl
ZCB0byBzdGF5IGF3YWtlIGZvciB0aGUgZHdjMyB0byBoYW5kbGUNCj4gPiB0aGVzZSBldmVudHMu
IEhtLi4uIGl0IGdldHMgYSBiaXQgY29tcGxpY2F0ZWQuDQo+IA0KPiBBcyB3ZSBhcmUgZ29pbmcg
aW50byBzdXNwZW5kLCB3ZSBhcmUgbm90IHJlYWxseSBpbiBhIHBvc2l0aW9uIHRvIGhhbmRsZSBh
bnkNCj4gKERFVlRFTikgZXZlbnRzIHRpbGwgd2UgaGF2ZSBmdWxseSByZXN1bWVkLg0KPiBTbyB5
ZXMsIHdlIG5lZWQgdG8gcmVseSBvbiBwbGF0Zm9ybSBzcGVjaWZpYyBpbXBsZW1lbnRhdGlvbiB0
byB3YWtlDQo+IHRoZSBTeXN0ZW0gb24gYW55IFVTQiBldmVudC4NCj4gDQoNCllvdSBtYXkgYmUg
YWJsZSB0byBkZXRlY3QgdmJ1cyBjaGFuZ2UgdGhyb3VnaCB0aGUgY29ubmVjdG9yIGNvbnRyb2xs
ZXIuDQpIb3dldmVyLCB0aGUgdXNiIGNvbnRyb2xsZXIgaXMgdGhlIG9uZSB0aGF0IGRldGVjdHMg
aG9zdCByZXN1bWUuIFdoYXQNCnBsYXRmb3JtIHNwZWNpZmljIGltcGxlbWVudGF0aW9uIGRvIHlv
dSBoYXZlIG91dHNpZGUgb2YgdGhlIHVzYg0KY29udHJvbGxlciBkbyB5b3UgaGF2ZSB0byBnZXQg
YXJvdW5kIHRoYXQ/DQoNCkknbSBub3Qgc3VyZSBpZiB5b3VyIHBsYXRmb3JtIHN1cHBvcnRzIGhp
YmVybmF0aW9uIG9yIGlmIHRoZSBQTUUgc2lnbmFsDQpvbiB5b3VyIHBsYXRmb3JtIGNhbiB3YWtl
dXAgdGhlIHN5c3RlbSwgYnV0IGN1cnJlbnRseSBkd2MzIGRyaXZlcg0KZG9lc24ndCBoYW5kbGUg
aGliZXJuYXRpb24gKGRldmljZSBzaWRlKS4gSWYgdGhlcmUncyBubyBoaWJlcm5hdGlvbiwNCnRo
ZXJlJ3Mgbm8gUE1FLg0KDQpCUiwNClRoaW5o
