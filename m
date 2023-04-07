Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64FA6DA6FB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 03:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238845AbjDGBbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 21:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233429AbjDGBbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 21:31:44 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D9B9EC8;
        Thu,  6 Apr 2023 18:31:41 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336N3MY0020969;
        Thu, 6 Apr 2023 18:31:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=ExiYnP3q2QlnTAzdvUlb4m6zmJlekxBJRSrMymwKqNg=;
 b=kZL/UNQ0U93zjlaJivF1PB9bvj9GnFLi9Rz9lwznE3iN9mqZdCQFbbKLPyXwGi0m84Eq
 x1l7C3+nWigElIjgjvC+2LeYa1nCTfuzx1AKOCJpZ8EzduGjpp5/lehMrKtMdrBMJ4YR
 OXTfsb/wrydnhHelkPhArwxa1lyBWl3IepQs1MW0BGigDUlB/XZCZOVj++KUoemLcdi7
 5xrScAzgGjmoKNCu920/iKCkRr8EVwnc0ygAEFfQlonBy8T91hmYet7Kq1QR0GihZZYf
 RwlviQa3ZowVQk/shOXwkNhHCkT2AZntuAhmRyfIB6htzEuIWQjilI6opXDk8uHgQEhs 2w== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3ppkmrwwqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 18:31:34 -0700
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CC09EC04C2;
        Fri,  7 Apr 2023 01:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1680831093; bh=ExiYnP3q2QlnTAzdvUlb4m6zmJlekxBJRSrMymwKqNg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=CIhAM1RVHRctoMTmlOJTc//lU0mv5jTncbztMF1NNfvPnwVKyo9mA5ZLDyafsvB56
         o4jHlM16du8F1/vrSXct+0qsgBfW79w1ILP1LxdqsnTSo7udid4gMuzKCaLLizpWMA
         Cc8KqbpJOtlSkVSyDZ1YnajrLqFN5ZPz60Dmd8kaWR6vA9UzfgjTj3zjH4ESrWBnt0
         a8DBDPxxPSBV1KvSccfGNBqm+ui51MQqI1LovUPO+3TJgQLsvz0evOKlNHrZkpeQO5
         T4NpP1tolIs2dB1TaQQtxf/++wq8/idTU5ItWxpcXePbxoRFdYESJmvwfbMAk9IJWN
         5CXQmKiMhwYqg==
Received: from o365relay-in.synopsys.com (unknown [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 8ABDBA0087;
        Fri,  7 Apr 2023 01:31:33 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2177.outbound.protection.outlook.com [104.47.73.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id A794680075;
        Fri,  7 Apr 2023 01:31:32 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="uQO4aZvf";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GnY9rMlk1eEiro0kJ+08evMmVFSHwar8m6vFsZqSwvSZQS+yhk/iU2nT4xtD7xsLr4C+hTPK452YIGUQ7Zj2zFcYuA53NHAB1K63sweAWhrayn7/PJblH+qeepDC9+LEevkAE1e6tRlQ4vfIAjjHhfPjvgVhUNbn7lzmX8c+hiJtSb9r+onP+y22uTl4vRZnR0TuaXPVrgPhaP9FjGngQMZkIsSS6b5nuICN/0I2uPSnW2av7XBHOioy2LFzB7ZZ62kJBm2pKAnPPvgAzFztDlxy+B8Ux2I+gARE/qon9fzN5RSkt+Elr12kAK6gEHExvma2++o1SqGugvO/rOvJKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExiYnP3q2QlnTAzdvUlb4m6zmJlekxBJRSrMymwKqNg=;
 b=JmBNw2jUCfaw6bPIbE4FZS/8zIKuu10NY00hCKU6oHlMwaQAcw/rRJaKJRGuqwvVR16Vgz+UekYR26c/TmsKbwK9NHrNwL8sVVoBdaJ4eoPxeapNU/49TF8BBFbdMExtftpod02Z7aUoro65t2PBPQxYGAIiPM62f9HOimkUelKSGlU/IYb5F58iQoimdMFigR6kLOV2Z6iIh7LKa2vgz92HOGFSvbqWf9T3D/n2uul8d9pWtG1L/asY4nceP+oRJthFC7w6oRjbznLUWwScJZUTY4yjiFxsw7e+MkTQpEdlBFfyHdtVcMwyAOcb6K4c+Bc/phF0DFugQ44pTWSUaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExiYnP3q2QlnTAzdvUlb4m6zmJlekxBJRSrMymwKqNg=;
 b=uQO4aZvfF9LNk3zq0ADk5LML/ASzeRQJ2s/k0OOXUusHxE78PR+6VfdijegLsT+K8sEbi7C0qoTST1f5w+l0YwUeGl0f3YuaIWpBUbe8O6sL1rg9FYNndwe7MgXxKZoJL/n59mWhrvjYPhlhoobnvztsC1WqM5pH7VhmGpYgb2k=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by PH7PR12MB7113.namprd12.prod.outlook.com (2603:10b6:510:1ec::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Fri, 7 Apr
 2023 01:31:29 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6254.035; Fri, 7 Apr 2023
 01:31:29 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Johan Hovold <johan+linaro@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/11] USB: dwc3: refactor phy handling
Thread-Topic: [PATCH 09/11] USB: dwc3: refactor phy handling
Thread-Index: AQHZZsawqKrv9d6tjUOv2NCMdleuz68fE7oA
Date:   Fri, 7 Apr 2023 01:31:28 +0000
Message-ID: <20230407013114.uw54zyddro5wlbw2@synopsys.com>
References: <20230404072524.19014-1-johan+linaro@kernel.org>
 <20230404072524.19014-10-johan+linaro@kernel.org>
In-Reply-To: <20230404072524.19014-10-johan+linaro@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|PH7PR12MB7113:EE_
x-ms-office365-filtering-correlation-id: b476abe6-d0f9-4f1f-56cc-08db3707cf91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5DsXbl1ExdIyNFCbHj3qCq6Bjs/8j4dQ1+XK1vC0BOlLk4m4svgiei5GMCQT9/dYHnYxismXB9ZeVwllJFm063oix2lwLeXSuS2tyUKbaWsTWujR5CnkcUg6PMcekRXvU9Q9cTSwCMF4wKTKvenQv00BtuUiWSin+oQS6AQUvQUl7PCNivVLLTEMPckaIkhVIAO5kg9DJxQLM9QdaxMcwL3ZOrw6uHidtVL/RST71uqDPD0xh5AArw6MBIx3zImr8sHC9ZTTd7szzf+daaSKvMpNGn7ZcR81nn0BHdGQ+aWqZj1VuBm6abq2/P2uafQtwGsfJPJpOFVHQ5vZYhlng99rWRaxPJIP/tfQX5F6alj3y15a1PUUHJ+n5U+J6cTU+w718q4LsOf12gtjPuPGW/fAPxtmnqfxWLe1OsNmafR4TROPMoGIuXuBl88qyctYmADH0npZRUZZp7Z7AuCyp1nJ0ipDHjHF0v3myt7kN/9XVt0Rt7nUlR3qFdSY9/zINaWfJ8CVXUcZ1YZe78KuFMkOtC1U6O8Sb4jpJCLGpiur5EFryUKucZ1wT3k/voXs+wREg7KpHWkuW1yVQfvQ492Vg/LXCtp1Q9iU2LawN69tLCnZAPBN3y6Fcl34uD6L
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(136003)(39860400002)(346002)(451199021)(38100700002)(6486002)(66476007)(76116006)(122000001)(6512007)(1076003)(2616005)(26005)(8936002)(6506007)(2906002)(5660300002)(186003)(478600001)(36756003)(54906003)(38070700005)(4326008)(8676002)(41300700001)(66946007)(66556008)(64756008)(71200400001)(86362001)(316002)(83380400001)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEhVcUhXT0lXVTdHbHFTSmlmVHo5dmt3Uml1SnVsNkdFamhjR2gyckk4ejgx?=
 =?utf-8?B?V2RhZDdTS1d1QklsQU5aYWZjOFY4YVhFV1FMZUhpTkVrZDROeHV1ek1aMGw1?=
 =?utf-8?B?Y0cyT1psdVRCVkVSY2RGRERYTU1BVjBxN0ZWT2RsZ0JCUzhwMmdTSlVaY2xp?=
 =?utf-8?B?amcxWE1pWlluUDNTcUdmUUQ3RUhWT0tMb1M0RHRUN1grR1JkelU1Vlc4L0xC?=
 =?utf-8?B?VXdXT3dCdjdRRVBFdVhZeGNKR2dvaVFYVFdJNU8vL0p6UGlUUTVVanFlWjFE?=
 =?utf-8?B?K2FvY2RILzA0ZWx0dWZzYURycnBiOC90SHpxckMzNy9NYW5MM3prT0JxY3Bq?=
 =?utf-8?B?Mkg0aEYzOXRxWFliRkc3V2llRDFYbk5RVzErMWlUZ1BOdnRyT1R4aEtJdHlt?=
 =?utf-8?B?eG5sNmV2eDNWdGhUMGMvRWswekp1QnlTZitkNzYzUlo2VUJjNW9vRzdUTXNE?=
 =?utf-8?B?cERER21RaS9PR1dNRUxxWnlOMUJhSThtK3BmY2UwVE9lRk9KTFV6ckRVN2ZN?=
 =?utf-8?B?MTJyclZmN3F2Z0RtdFY3WEF6Zlo5ZldFeUEzaW84SVZDR2tna0RRVUg1SlQx?=
 =?utf-8?B?QWJKcUtvQkp0eHZBdmtLMy9ndmhSUUNtbHVxWEhXS0luOUJHbjVYeG85Nk5h?=
 =?utf-8?B?K05NZUI1eW5xUjdxK1ZibGNzb01FcTVJVHNXekFaZi82dVJwVCsxMHgwVmxM?=
 =?utf-8?B?RHVJTGhZTFIxRHBpeWxKZjlnUXV1Vzk1QjlFcVdQSU0xb3pDQ0VqTjJYdCtO?=
 =?utf-8?B?dXZYZVQ0YUpiQ0JlV01QR29ZczVWWlplTm9GUVJ3TVRqcGhsSWNsUXVyeEVO?=
 =?utf-8?B?akJDM1kyTmlOVmVmcUIzYkduZ3ljM0NUcm9NTVE3dVMwdUlaK2I5NmY0N1lI?=
 =?utf-8?B?bVM5aXh1eFl6V09RUWgzM2xLYVozT0NnUnV5alQ4TVhDV2tsaTExQ25oY3Bl?=
 =?utf-8?B?a2k1OFlRYVc4REtsdXFidXE5NzRYOHNaejFqSUZpK0grNnRlekpQWGc4b1V4?=
 =?utf-8?B?L2Y5bVVhS3BURXNoMDdhVWdPVzE3VUh0aGt2U2hoVVBCZkYxYUpBOVkvanEy?=
 =?utf-8?B?ZjhnUTJBaUU5VnU3RjlqNjkyazNxSFRLRkhzTWpaSVgrMmlxODlSKy9xMHRE?=
 =?utf-8?B?MUttOGh4aTZ0Wit3UlMrMkV6S3BUa3MzdXowdEFEMDVGd1dMRFhodEpUTWNG?=
 =?utf-8?B?RGZ1NTVwMktJWFZsZm1Sek1ab04yWjZ5WnltTDk3Y1IrL3RXS0d1dlhHSGwv?=
 =?utf-8?B?c1VhMlZ0cTVCZmdLS3hFay9nZ1NxMEU3YUFsQXFIV2xRMm96YWpvQlZMYndJ?=
 =?utf-8?B?aStrdXUxZ0VGaGFqeWU3NXpvcXpXZm9mcnc0eGZjbFQ3ai9ZS1FscGJKeGZp?=
 =?utf-8?B?Y0lEc0RHM2NGd0tPK0xseUd3eGpXdVdyS1lzdlp1a1k2Q3IvN3VYdlFZaG5N?=
 =?utf-8?B?VjMwTC93TU4vSHRTVFd5NDEvNFRGZ0VuZDdGTVRMemRESkVFdXBad1dRL1VG?=
 =?utf-8?B?bzFjV2NOcUlqdFpISFBYcVNTREdPdEExaWs0OXVCcGREZU5CZ21IRnRnU0JY?=
 =?utf-8?B?WHJqZCt5akwyRUhFSzRlOW5JRHZiek56d2MzZHVDN0I4MzBhV2NBUWZkMVBL?=
 =?utf-8?B?cWJYc3FMeXJoNGQzaWZiTWVYWFBlYk5ERG9VSDVvNEpBVFVHZEhlSDBGTjB5?=
 =?utf-8?B?aHNuZEhXbEgxZ0pmN08zQTNwdHdRNVMzaUNpRXZJOGFkOWk3T2RjK21rUFZ4?=
 =?utf-8?B?UTBjeU1tWVJVZTJ2b3dGOFIyRDBNYzlyc0E1MXQrbVFTZVdodlVGcnRtSHZn?=
 =?utf-8?B?WXNRalN2d0Uzb2JwZSsya3RKYU5XM2pLdTh5ZE9iYUZJVVczUXc3V1IzME0w?=
 =?utf-8?B?OXdFRmg1b01VUTZUS3g3bEtNOWl4RDlydEU0UDUydGRwYXNNcXU2TWx2MHJo?=
 =?utf-8?B?aUU3Z1ZiaEZ2WGsrM2ZVS0dDRjQ0czdTd0NNK3N5dGN3SnRiSS9lTm43Rjdw?=
 =?utf-8?B?SG9FbkhaNVh2ci93UlRJeHRUUEhqR1cxenV1clpHTEFaNjI2VmNuNEF2bk94?=
 =?utf-8?B?K0tHYisrdStsVDc0U0RJUW9ML1lzV243elZ2L1ZJVzJBazF5WTdXL0lvMTA1?=
 =?utf-8?Q?MFwGHprIt6NG0aVbTyqLT/3K+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4BA692597EEA314C9B355BA85C0DB0AE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rbYYmPj2yI7awO+b+qvB0WOLs+UwgJtQ5C35kXfC5875r8URht7TtLeQC7T9U8QspEG1qN3v4dTiJ6wJalIJ7eXXMnxWTTRhxWLMTsfbe82vpbidahpGx7I1RxeLqTs7EGJp2FETWGuWB5BdPik3V9+z9O+HSIZsVV8H3JT+lEM6he9iofsMPBI6Cx0rYTQHEgHl7QELdcLrfCkkZLEUjaQCRwNdA1urFT2C76nn+oIDxNobQ1ueH6BcqRS0YXRvotAxBvDC8PCQJD+dqdKRWMsPP2zWN2SVQ87siXqpdtgLzoXiMhBgcDqfyuHQ2o5LIXpe2RuPQglrIXNFdBWTP9TYxQD8aedUr1zb/V2khgaFRR8uHsRh5ZBK8IJ98j3AT7Aapna/iZWU0xXMhrD7W9pF6UzLsNN4HQfhaU73h82rFztipfu1xr8/lomJ+qURWtiMjOhJ97LnaAIAh3NW7ZrLONXZdyc23E0Yo7hqEJiUYDWuv7yW9IodXDAcHd/Uhu6W5b+8kTtw6W9Gvm2drDrGZ3u8flviRK2kU8rBuUJ+VvRswJbTjyP0Te0xeeNIfvmZBTCKfdsJ/XT5BS8jc1bn+WTFMv5Y9qHv2/M6f3OYz9kg1LcOaYrE2OAE0LWAFh8HLHfRQWcEoBN21fMB5Th47j1bH+QUjirKQBI6pKi2feEukCBZ09tKUe38o4Y7+TmiTeyrM8qqioZKvstuGiEQA5+dC1xdOF8VpneqJOYjKzSF0xh+f6W44TdJwl67SiVoScZI8Pm9IknvLXzlFm99R1o0wUX3nZzhebh2i9TO0twNvUUQoMMTywXz6jT1UZAmVgQ92f3+sIpEKdZW/I9gILYIeY+O7ARF9aq9A8ktuHYQt883Vd1ydXp9s9JP
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b476abe6-d0f9-4f1f-56cc-08db3707cf91
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2023 01:31:28.9511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7+1AtwmnbE7a6XzRKBaceuMT3yyhI97yvarGKmbT4QBSLpi6QuhQ/8adLSUDUTk9tN+ibDeVhe2xXFA1gnm+6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7113
X-Proofpoint-ORIG-GUID: 6P5n_JyziJ5_MZitWLwPwxi9S5zcyY5I
X-Proofpoint-GUID: 6P5n_JyziJ5_MZitWLwPwxi9S5zcyY5I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_14,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 impostorscore=0
 phishscore=0 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304070012
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBBcHIgMDQsIDIwMjMsIEpvaGFuIEhvdm9sZCB3cm90ZToNCj4gUmVmYWN0b3IgdGhl
IFBIWSBoYW5kbGluZyB1c2luZyBmb3VyIG5ldyBoZWxwZXJzIHRvIGluaXRpYWxpc2UsDQo+IGRl
aW5pdGlhbGlzZSwgcG93ZXIgb24gYW5kIHBvd2VyIG9mZiBhbGwgdGhlIFBIWXMuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBKb2hhbiBIb3ZvbGQgPGpvaGFuK2xpbmFyb0BrZXJuZWwub3JnPg0KPiAt
LS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jIHwgMTQzICsrKysrKysrKysrKysrKysrKysr
KysrKy0tLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA4NiBpbnNlcnRpb25zKCsp
LCA1NyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2Nv
cmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IGluZGV4IGM0OTllZjAyNjUwMC4uNTJj
ZDVkZGZlYmQ1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiArKysg
Yi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBAQCAtNzIxLDYgKzcyMSw3NiBAQCBzdGF0aWMg
aW50IGR3YzNfcGh5X3NldHVwKHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJcmV0dXJuIDA7DQo+ICB9
DQo+ICANCj4gK3N0YXRpYyBpbnQgZHdjM19waHlfaW5pdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAr
ew0KPiArCWludCByZXQ7DQo+ICsNCj4gKwl1c2JfcGh5X2luaXQoZHdjLT51c2IyX3BoeSk7DQo+
ICsJdXNiX3BoeV9pbml0KGR3Yy0+dXNiM19waHkpOw0KPiArDQo+ICsJcmV0ID0gcGh5X2luaXQo
ZHdjLT51c2IyX2dlbmVyaWNfcGh5KTsNCj4gKwlpZiAocmV0IDwgMCkNCj4gKwkJZ290byBlcnJf
c2h1dGRvd25fdXNiM19waHk7DQo+ICsNCj4gKwlyZXQgPSBwaHlfaW5pdChkd2MtPnVzYjNfZ2Vu
ZXJpY19waHkpOw0KPiArCWlmIChyZXQgPCAwKQ0KPiArCQlnb3RvIGVycl9leGl0X3VzYjJfcGh5
Ow0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICsNCj4gK2Vycl9leGl0X3VzYjJfcGh5Og0KPiArCXBo
eV9leGl0KGR3Yy0+dXNiMl9nZW5lcmljX3BoeSk7DQo+ICtlcnJfc2h1dGRvd25fdXNiM19waHk6
DQo+ICsJdXNiX3BoeV9zaHV0ZG93bihkd2MtPnVzYjNfcGh5KTsNCj4gKwl1c2JfcGh5X3NodXRk
b3duKGR3Yy0+dXNiMl9waHkpOw0KPiArDQo+ICsJcmV0dXJuIHJldDsNCj4gK30NCj4gKw0KPiAr
c3RhdGljIHZvaWQgZHdjM19waHlfZXhpdChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiArew0KPiArCXBo
eV9leGl0KGR3Yy0+dXNiM19nZW5lcmljX3BoeSk7DQo+ICsJcGh5X2V4aXQoZHdjLT51c2IyX2dl
bmVyaWNfcGh5KTsNCj4gKw0KPiArCXVzYl9waHlfc2h1dGRvd24oZHdjLT51c2IzX3BoeSk7DQo+
ICsJdXNiX3BoeV9zaHV0ZG93bihkd2MtPnVzYjJfcGh5KTsNCj4gK30NCj4gKw0KPiArc3RhdGlj
IGludCBkd2MzX3BoeV9wb3dlcl9vbihzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiArew0KPiArCWludCBy
ZXQ7DQo+ICsNCj4gKwl1c2JfcGh5X3NldF9zdXNwZW5kKGR3Yy0+dXNiMl9waHksIDApOw0KPiAr
CXVzYl9waHlfc2V0X3N1c3BlbmQoZHdjLT51c2IzX3BoeSwgMCk7DQo+ICsNCj4gKwlyZXQgPSBw
aHlfcG93ZXJfb24oZHdjLT51c2IyX2dlbmVyaWNfcGh5KTsNCj4gKwlpZiAocmV0IDwgMCkNCj4g
KwkJZ290byBlcnJfc3VzcGVuZF91c2IzX3BoeTsNCj4gKw0KPiArCXJldCA9IHBoeV9wb3dlcl9v
bihkd2MtPnVzYjNfZ2VuZXJpY19waHkpOw0KPiArCWlmIChyZXQgPCAwKQ0KPiArCQlnb3RvIGVy
cl9wb3dlcl9vZmZfdXNiMl9waHk7DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gKw0KPiArZXJyX3Bv
d2VyX29mZl91c2IyX3BoeToNCj4gKwlwaHlfcG93ZXJfb2ZmKGR3Yy0+dXNiMl9nZW5lcmljX3Bo
eSk7DQo+ICtlcnJfc3VzcGVuZF91c2IzX3BoeToNCj4gKwl1c2JfcGh5X3NldF9zdXNwZW5kKGR3
Yy0+dXNiM19waHksIDEpOw0KPiArCXVzYl9waHlfc2V0X3N1c3BlbmQoZHdjLT51c2IyX3BoeSwg
MSk7DQo+ICsNCj4gKwlyZXR1cm4gcmV0Ow0KPiArfQ0KPiArDQo+ICtzdGF0aWMgdm9pZCBkd2Mz
X3BoeV9wb3dlcl9vZmYoc3RydWN0IGR3YzMgKmR3YykNCj4gK3sNCj4gKwlwaHlfcG93ZXJfb2Zm
KGR3Yy0+dXNiM19nZW5lcmljX3BoeSk7DQo+ICsJcGh5X3Bvd2VyX29mZihkd2MtPnVzYjJfZ2Vu
ZXJpY19waHkpOw0KPiArDQo+ICsJdXNiX3BoeV9zZXRfc3VzcGVuZChkd2MtPnVzYjNfcGh5LCAx
KTsNCj4gKwl1c2JfcGh5X3NldF9zdXNwZW5kKGR3Yy0+dXNiMl9waHksIDEpOw0KPiArfQ0KPiAr
DQo+ICBzdGF0aWMgaW50IGR3YzNfY2xrX2VuYWJsZShzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgew0K
PiAgCWludCByZXQ7DQo+IEBAIC03NTYsMTcgKzgyNiw4IEBAIHN0YXRpYyB2b2lkIGR3YzNfY2xr
X2Rpc2FibGUoc3RydWN0IGR3YzMgKmR3YykNCj4gIHN0YXRpYyB2b2lkIGR3YzNfY29yZV9leGl0
KHN0cnVjdCBkd2MzICpkd2MpDQo+ICB7DQo+ICAJZHdjM19ldmVudF9idWZmZXJzX2NsZWFudXAo
ZHdjKTsNCj4gLQ0KPiAtCXVzYl9waHlfc2V0X3N1c3BlbmQoZHdjLT51c2IyX3BoeSwgMSk7DQo+
IC0JdXNiX3BoeV9zZXRfc3VzcGVuZChkd2MtPnVzYjNfcGh5LCAxKTsNCj4gLQlwaHlfcG93ZXJf
b2ZmKGR3Yy0+dXNiMl9nZW5lcmljX3BoeSk7DQo+IC0JcGh5X3Bvd2VyX29mZihkd2MtPnVzYjNf
Z2VuZXJpY19waHkpOw0KPiAtDQo+IC0JdXNiX3BoeV9zaHV0ZG93bihkd2MtPnVzYjJfcGh5KTsN
Cj4gLQl1c2JfcGh5X3NodXRkb3duKGR3Yy0+dXNiM19waHkpOw0KPiAtCXBoeV9leGl0KGR3Yy0+
dXNiMl9nZW5lcmljX3BoeSk7DQo+IC0JcGh5X2V4aXQoZHdjLT51c2IzX2dlbmVyaWNfcGh5KTsN
Cj4gLQ0KPiArCWR3YzNfcGh5X3Bvd2VyX29mZihkd2MpOw0KPiArCWR3YzNfcGh5X2V4aXQoZHdj
KTsNCj4gIAlkd2MzX2Nsa19kaXNhYmxlKGR3Yyk7DQo+ICAJcmVzZXRfY29udHJvbF9hc3NlcnQo
ZHdjLT5yZXNldCk7DQo+ICB9DQo+IEBAIC0xMDI5LDIwICsxMDkwLDEzIEBAIHN0YXRpYyBpbnQg
ZHdjM19jb3JlX2luaXQoc3RydWN0IGR3YzMgKmR3YykNCj4gIAkJZHdjLT5waHlzX3JlYWR5ID0g
dHJ1ZTsNCj4gIAl9DQo+ICANCj4gLQl1c2JfcGh5X2luaXQoZHdjLT51c2IyX3BoeSk7DQo+IC0J
dXNiX3BoeV9pbml0KGR3Yy0+dXNiM19waHkpOw0KPiAtDQo+IC0JcmV0ID0gcGh5X2luaXQoZHdj
LT51c2IyX2dlbmVyaWNfcGh5KTsNCj4gLQlpZiAocmV0IDwgMCkNCj4gLQkJZ290byBlcnJfc2h1
dGRvd25fdXNiM19waHk7DQo+IC0NCj4gLQlyZXQgPSBwaHlfaW5pdChkd2MtPnVzYjNfZ2VuZXJp
Y19waHkpOw0KPiAtCWlmIChyZXQgPCAwKQ0KPiAtCQlnb3RvIGVycl9leGl0X3VzYjJfcGh5Ow0K
PiArCXJldCA9IGR3YzNfcGh5X2luaXQoZHdjKTsNCj4gKwlpZiAocmV0KQ0KPiArCQlnb3RvIGVy
cl9leGl0X3VscGk7DQo+ICANCj4gIAlyZXQgPSBkd2MzX2NvcmVfc29mdF9yZXNldChkd2MpOw0K
PiAgCWlmIChyZXQpDQo+IC0JCWdvdG8gZXJyX2V4aXRfdXNiM19waHk7DQo+ICsJCWdvdG8gZXJy
X2V4aXRfcGh5Ow0KPiAgDQo+ICAJaWYgKGh3X21vZGUgPT0gRFdDM19HSFdQQVJBTVMwX01PREVf
RFJEICYmDQo+ICAJICAgICFEV0MzX1ZFUl9JU19XSVRISU4oRFdDMywgQU5ZLCAxOTRBKSkgew0K
PiBAQCAtMTA3MywyMCArMTEyNywxNCBAQCBzdGF0aWMgaW50IGR3YzNfY29yZV9pbml0KHN0cnVj
dCBkd2MzICpkd2MpDQo+ICANCj4gIAlkd2MzX3NldF9pbmNyX2J1cnN0X3R5cGUoZHdjKTsNCj4g
IA0KPiAtCXVzYl9waHlfc2V0X3N1c3BlbmQoZHdjLT51c2IyX3BoeSwgMCk7DQo+IC0JdXNiX3Bo
eV9zZXRfc3VzcGVuZChkd2MtPnVzYjNfcGh5LCAwKTsNCj4gLQlyZXQgPSBwaHlfcG93ZXJfb24o
ZHdjLT51c2IyX2dlbmVyaWNfcGh5KTsNCj4gLQlpZiAocmV0IDwgMCkNCj4gLQkJZ290byBlcnJf
c3VzcGVuZF91c2IzX3BoeTsNCj4gLQ0KPiAtCXJldCA9IHBoeV9wb3dlcl9vbihkd2MtPnVzYjNf
Z2VuZXJpY19waHkpOw0KPiAtCWlmIChyZXQgPCAwKQ0KPiAtCQlnb3RvIGVycl9wb3dlcl9vZmZf
dXNiMl9waHk7DQo+ICsJZHdjM19waHlfcG93ZXJfb24oZHdjKTsNCj4gKwlpZiAocmV0KQ0KPiAr
CQlnb3RvIGVycl9leGl0X3BoeTsNCj4gIA0KPiAgCXJldCA9IGR3YzNfZXZlbnRfYnVmZmVyc19z
ZXR1cChkd2MpOw0KPiAgCWlmIChyZXQpIHsNCj4gIAkJZGV2X2Vycihkd2MtPmRldiwgImZhaWxl
ZCB0byBzZXR1cCBldmVudCBidWZmZXJzXG4iKTsNCj4gLQkJZ290byBlcnJfcG93ZXJfb2ZmX3Vz
YjNfcGh5Ow0KPiArCQlnb3RvIGVycl9wb3dlcl9vZmZfcGh5Ow0KPiAgCX0NCj4gIA0KPiAgCS8q
DQo+IEBAIC0xMjAzLDIwICsxMjUxLDEwIEBAIHN0YXRpYyBpbnQgZHdjM19jb3JlX2luaXQoc3Ry
dWN0IGR3YzMgKmR3YykNCj4gIA0KPiAgCXJldHVybiAwOw0KPiAgDQo+IC1lcnJfcG93ZXJfb2Zm
X3VzYjNfcGh5Og0KPiAtCXBoeV9wb3dlcl9vZmYoZHdjLT51c2IzX2dlbmVyaWNfcGh5KTsNCj4g
LWVycl9wb3dlcl9vZmZfdXNiMl9waHk6DQo+IC0JcGh5X3Bvd2VyX29mZihkd2MtPnVzYjJfZ2Vu
ZXJpY19waHkpOw0KPiAtZXJyX3N1c3BlbmRfdXNiM19waHk6DQo+IC0JdXNiX3BoeV9zZXRfc3Vz
cGVuZChkd2MtPnVzYjNfcGh5LCAxKTsNCj4gLQl1c2JfcGh5X3NldF9zdXNwZW5kKGR3Yy0+dXNi
Ml9waHksIDEpOw0KPiAtZXJyX2V4aXRfdXNiM19waHk6DQo+IC0JcGh5X2V4aXQoZHdjLT51c2Iz
X2dlbmVyaWNfcGh5KTsNCj4gLWVycl9leGl0X3VzYjJfcGh5Og0KPiAtCXBoeV9leGl0KGR3Yy0+
dXNiMl9nZW5lcmljX3BoeSk7DQo+IC1lcnJfc2h1dGRvd25fdXNiM19waHk6DQo+IC0JdXNiX3Bo
eV9zaHV0ZG93bihkd2MtPnVzYjNfcGh5KTsNCj4gLQl1c2JfcGh5X3NodXRkb3duKGR3Yy0+dXNi
Ml9waHkpOw0KPiArZXJyX3Bvd2VyX29mZl9waHk6DQo+ICsJZHdjM19waHlfcG93ZXJfb2ZmKGR3
Yyk7DQo+ICtlcnJfZXhpdF9waHk6DQo+ICsJZHdjM19waHlfZXhpdChkd2MpOw0KPiAgZXJyX2V4
aXRfdWxwaToNCj4gIAlkd2MzX3VscGlfZXhpdChkd2MpOw0KPiAgDQo+IEBAIC0xODMyLDE3ICsx
ODcwLDggQEAgc3RhdGljIGludCBkd2MzX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYpDQo+ICBlcnJfZXhpdF9kZWJ1Z2ZzOg0KPiAgCWR3YzNfZGVidWdmc19leGl0KGR3Yyk7DQo+
ICAJZHdjM19ldmVudF9idWZmZXJzX2NsZWFudXAoZHdjKTsNCj4gLQ0KPiAtCXVzYl9waHlfc2V0
X3N1c3BlbmQoZHdjLT51c2IyX3BoeSwgMSk7DQo+IC0JdXNiX3BoeV9zZXRfc3VzcGVuZChkd2Mt
PnVzYjNfcGh5LCAxKTsNCj4gLQlwaHlfcG93ZXJfb2ZmKGR3Yy0+dXNiMl9nZW5lcmljX3BoeSk7
DQo+IC0JcGh5X3Bvd2VyX29mZihkd2MtPnVzYjNfZ2VuZXJpY19waHkpOw0KPiAtDQo+IC0JdXNi
X3BoeV9zaHV0ZG93bihkd2MtPnVzYjJfcGh5KTsNCj4gLQl1c2JfcGh5X3NodXRkb3duKGR3Yy0+
dXNiM19waHkpOw0KPiAtCXBoeV9leGl0KGR3Yy0+dXNiMl9nZW5lcmljX3BoeSk7DQo+IC0JcGh5
X2V4aXQoZHdjLT51c2IzX2dlbmVyaWNfcGh5KTsNCj4gLQ0KPiArCWR3YzNfcGh5X3Bvd2VyX29m
Zihkd2MpOw0KPiArCWR3YzNfcGh5X2V4aXQoZHdjKTsNCj4gIAlkd2MzX3VscGlfZXhpdChkd2Mp
Ow0KPiAgZXJyX2ZyZWVfZXZlbnRfYnVmZmVyczoNCj4gIAlkd2MzX2ZyZWVfZXZlbnRfYnVmZmVy
cyhkd2MpOw0KPiAtLSANCj4gMi4zOS4yDQo+IA0KDQpBY2tlZC1ieTogVGhpbmggTmd1eWVuIDxU
aGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpUaGFua3MsDQpUaGluaA==
