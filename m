Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DD76F61A3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 01:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjECXBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 19:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjECXBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 19:01:11 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1782E4EE3;
        Wed,  3 May 2023 16:01:10 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343J8Rlc023286;
        Wed, 3 May 2023 16:01:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=VNjZb0byF2aJTejXaEUKIaxlyFA5WPT2l/GzU0pRBAg=;
 b=qyutplQSqQtmiVdq1VBYezlp/QXv2c2OeA/WP41Nm/bbVOqFUjYSjFM/PcdZMe77J1QV
 p6omI/NrL+5EzG4SgrcFkgAieopVOySIUzTJJQ6FtSBHtqYN0i4mz15nxEEKzVwpMbsh
 CS5lqGcH55JFYzF5gobfUCvDOmhKBgHDlHIDyysD9AQMdgUzyWBbUCzgJySbTz3ewj3M
 bxy8q9FhbvOwS/73zC7OXcMblN9unV5OFXh/f8MGeifNTlP1stdUffRO/WDhTBfbGv65
 3opdvGFeXwtgRksqRdV3Lt0E9FqXrMyD4GsCdTYYcmUIweVH9xpWzUrJHcU6OSAIoBWE bg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3q91vjdc98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 May 2023 16:01:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1683154866; bh=VNjZb0byF2aJTejXaEUKIaxlyFA5WPT2l/GzU0pRBAg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Yv5fcuvwx1hfEiaZKT87ByPZflGVYeAQ+NeYGHEgRhfu1ggoIxlZlkxM1K8eeZsUX
         kD54k3sizENU87RwBzkA6OKayar4+GozwIL7JbEK4M5WK4MUDbidUwTX0sa7DpnyxP
         6gmohI1knMqxWM/9779kkj+o1i7Wt4sZ/fOYh01gHQZmIpiDrKNJpuaCiF51unSyo/
         Ijfe29iTzZXwpAue5r6GHYcVV2jhft9hZmn4rt4isF+slhLDDd33GIPLEmbdUkUBKW
         Dk1Sifr0raULSt4DRcwPvdFZjDrk9FlPA2LEKv2eflCnhubZXYZL1GoX+GlXx/oKrN
         PYGSRToVQgk8g==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B6618404D5;
        Wed,  3 May 2023 23:01:05 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 121DAA0083;
        Wed,  3 May 2023 23:01:04 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=qNomfyd/;
        dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 913A84045F;
        Wed,  3 May 2023 23:01:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VeYTswhQuZGX2CQOlOkA2utvCPQ4lBJ7RAQ9D57lov6tQjqb/4jzWuB57+PrO4hw5Nh40IIEMq37IrhGuN4zp1GfRgLaheQ3pHKrNcgbhYIYP6D6i93eGT2yDHnzs40zUaMpEZhfI2gSnskfYfXQfv2yvkzYsCrhX0qRjYeXbnBBGc847QXRtSP84Vx0A7dzLbZ9AI59FKNho6525CmKwcFwWhGd4u+7HVJdGT715QSC7y66Ckc3g2Erkd4HGhoAcQaMXysaycrhObiKy1kg/6zKVkiaibvZp0DkGzgzM0WAbhdrRk5ps7ksA2j4UHYexEML2TCwaoiWRaVOS42FnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VNjZb0byF2aJTejXaEUKIaxlyFA5WPT2l/GzU0pRBAg=;
 b=Ah1l20bDL/g7hS4X8t2/m6rvURV/4xfdpMl5o8Gx7j1Vd2f/e7I86ztM5PrdeuYVpSTJfxDYoKkdAoJUv/75EeTysCVUm1JW82BjFtVWkvG7pdwFLvdL7dXjFKIdGvg/kmJd11DQ+NxxHBCL+qtwe2txqEYnl0yinC/84+hJGyss0k3N5b4LMIu6kUEaMpMUnF2YPoWzGzjgYxnlITvK0MMZHIREJkZohIO3whFSf/6CMEPqEdbJVuVhiWPQ4n6vugr9UYw6CbGerI14sPyCGRq3jJsB/4e1fNUm6Z8eWytFZJPq1sKi4OLAZC3XWCVQzHH/u8WaG3gXOTRaFPPIxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNjZb0byF2aJTejXaEUKIaxlyFA5WPT2l/GzU0pRBAg=;
 b=qNomfyd/wbsU+qqDh4zvmofnQykux42ClNynJqRdmTvqXkMyCn0MdkQkqW60cadygnnYnQ1Ji4UclZtLEUe9ywCWzwBkyA+42ktWCOBTUnB7iTdwTWKf+azMU3uciyI5jl0+OBeInpiu31ZbyZLFPMPO5YtOL0U74jYjGHMskAs=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by CH3PR12MB8902.namprd12.prod.outlook.com (2603:10b6:610:17d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 23:00:58 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::bb79:9aea:e237:688c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::bb79:9aea:e237:688c%7]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 23:00:58 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Roy Luo <royluo@google.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "badhri@google.com" <badhri@google.com>
Subject: Re: [PATCH v1] usb: dwc3: Add error logs for unknown endpoint events
Thread-Topic: [PATCH v1] usb: dwc3: Add error logs for unknown endpoint events
Thread-Index: AQHZfVaoabEEC4QX9E+6xftEeLbH369JK4uA
Date:   Wed, 3 May 2023 23:00:58 +0000
Message-ID: <20230503230053.mbhh6p2h4qakfc65@synopsys.com>
References: <20230503003144.3782774-1-royluo@google.com>
In-Reply-To: <20230503003144.3782774-1-royluo@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|CH3PR12MB8902:EE_
x-ms-office365-filtering-correlation-id: 483637f2-f0a0-4bb9-3cd4-08db4c2a41f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OXoCh537Sqjn3OaaqPPABsSx5uUWwVjSvCHYHMpuP87vTNNqhy4QdjrLKngyiGAzLvjOH24TLLIFnc8uUx8bkjvvZXXFf05EgteXk3lQSEXzHsf98ub+b4L8bZm3Xh8I4e4mTuxXGnSm68gYWCgVE09aTDfJGm642SZWQ6u6ooh5swyNznEeAy5Xz+LAIjRbGYm7iUIqPUcoXBTVdaWtaa1IUI3fZh9aIUGWNdH3+7E2cNaj/+gibryeTptCmJPZd/xqGO8yDf4yTPGFiRowRHe5XNIjSnDJj4Ea/Me7AtXLkHvF2zWBkKAs+Mt0WZKfqseUKZMBvO0pVXXdJZUuBaptV+r4IVlzCEr3chI8Ecl73srnIGfXszxKpNkS/SQDGcGz1XVXGIgNASjOrimcNnteH0Y9K3JhXHvCJuiO5Q4caKYiT8dRsx9rgCCj5vfKTfpZJPE6iQG11NmD/seWHdmSAHv1354eeb6NabZJ10WFVYu8m3ov3xMa9yU/y4p4YEw2w33vJk/eEz93h2TSUBHvQJF0aTQfliVyZZCzo5sWNqsWjJABjc8+k17UJrvOxUk4QZDgp6Juy03859iyyxKfUS7XBOpnSht3ZCHw0LiCVvn3fg2Ae69VRMx06cH7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(39860400002)(346002)(366004)(451199021)(38070700005)(2906002)(38100700002)(41300700001)(122000001)(8676002)(8936002)(5660300002)(36756003)(86362001)(71200400001)(26005)(1076003)(6506007)(6486002)(54906003)(478600001)(2616005)(6512007)(186003)(4326008)(316002)(76116006)(66556008)(66946007)(66476007)(64756008)(6916009)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dTYrWXRnWWs5NTFuVUNSYnRjV0xOYjZJeFk0TGRob1k4MSs1cjZLVTFLWFR2?=
 =?utf-8?B?bm51bzFlbzVRQnN2dXNjb3VKS3FvbGFiNkwyYlZzb2JEcXNWazJwSEZwWmVF?=
 =?utf-8?B?UkU1ZjhKSDc4MmV0cWk4YlFwd2lQQmpITExTZVA2eVB0SkEwQ2dHbGJKK1M3?=
 =?utf-8?B?RnhpaVhydkVVZHl2ZEV6TFVWVTVpOU9yYjZHeWI1RVo1bElwcEtXMXhiTHNN?=
 =?utf-8?B?V1NEYzJQeVlHellvT21Fc1dGYUtVcGhpSXIvYW0zNmwyZGpFT244SjU4a3dC?=
 =?utf-8?B?RXlFRk5wUG04UktOWFl0Wm9uSmROZ1NmTXdhQ1RwU1R6WmJodGpTZE9CM0VW?=
 =?utf-8?B?RStjMWoxc2RNYjJiTW13OVRPemZWMFJUN2dLTWwwTzE4Y1FsVHJFV09jbm1n?=
 =?utf-8?B?TTBId3o3OW5nRkt6SUhiQWlBYjF5UWJDcktDR0NUT01JakxIODZXQ00vVHg0?=
 =?utf-8?B?M2ErWVpLeTJpYjNhczVGNmRzd1NlL3BqSWcwVktPK1pUczkyVWQ3VExvcjlx?=
 =?utf-8?B?bHdqeFZPcFJnVFVZR2llQjVSb0NWbmRkYnlyTnExR20rME1SanB4T1pmd2Fo?=
 =?utf-8?B?YjBKNXpLTHJHbUduZ0FWTjNVZHdVM1N5ajZ0YU1ZRGEwV281MXV4by9uaGNk?=
 =?utf-8?B?UFNIaDQxTHp6Vy94TEZQdU5KK3o1WUtTY2hqYnM3NlFwUnNPMExkVXNGU1NC?=
 =?utf-8?B?c3M4cHYwOFhJdzVCK2d2RkgxS3dBUVNLejEzaVYwZHRFYVY1UHRMZSt2N2RP?=
 =?utf-8?B?RTJWNnpYZktqMGNIZFF0T2VjZmhKN0lpNnQ0OXVCNFUxamtzUmxMLzA2R3Rr?=
 =?utf-8?B?aG43MzhyYzJ3Y2dKeVRlZEszZi9VMk1ndktTcU5VLzVyaWNFdnNXK2RhMFkr?=
 =?utf-8?B?bUxBQ05ZZTlyazZjMGUwclVIY1pneFFNRDdTTVY4RHN1MnR5WS96SW13SFFV?=
 =?utf-8?B?aFRBMXFURWp1dElrVlNrWDBFTlJaZFdXWDQrZFo3T0tjbENKeEtSemdBemVq?=
 =?utf-8?B?R3hNUWoxVjJZaklJU0VsVG5HRFhYUXJQTGxkMHordndNdEdpWWNJazVNS09j?=
 =?utf-8?B?ekJSNThMNWFRb2pJS2NlK1dWSnlPMXA2S2dEdWtzUnlHaXIxQUU4dkxhQVZG?=
 =?utf-8?B?RlRNVEF6TmZldGQzb1J1YjUyUlBBcnZKUW5TbjEyMjRDc3FKeVhFdUxkamdx?=
 =?utf-8?B?d0U0azJqSG9oaURzc0dVV2dFQ1UxQmlEdG1wMFMybnkwK3Q4RVdYdmx0bEsr?=
 =?utf-8?B?c3RoRm5VOGtmSGFTRXlaQ2gwRFVaWU9iNDA5ZWsvazhIdm50bXNJRnpZVFRC?=
 =?utf-8?B?NExaK0txZkJ2cndMdi9zOEZRVXN6blB6TWo5ejBIRFBTS3lLZVFUeXRwUGhz?=
 =?utf-8?B?cUxnVXVmSnNBQ0crbmNqZjhMdjJpZitTc0RSWDFScTNndkZDSWp2cVcyWk5X?=
 =?utf-8?B?bGNocXpyWFZGZGVOUWxhVmwxYWRoVkdGbjl6V0xqV3RsQlpsYjY4RjFlZk9I?=
 =?utf-8?B?dkR6WUlNbjVDemQwNnU4TzBIcXRoSUZaNUtSMEcxUThNWmFFRk9XWmExK0xU?=
 =?utf-8?B?UTBLMnVFdGhMMHlnS2tldmlDUkhueGlaQW9HMTVFSXNqbXhGZVdKbEJjcTJB?=
 =?utf-8?B?WEpUUUNMb0laUEcyT203eDlLajQ4cG1HZHJiaWtlWUVndW8weUcyUDZVK0ZS?=
 =?utf-8?B?aDZ4TnJ4ZG9KLzlLMVowdkFFS0M2K2N1Uy8yeXQ3eEJ6NklubUVUY3FOK2J5?=
 =?utf-8?B?TElzSnRoeHhySW9hRms5bUdNKys0NUZ2NmtmaTJnSTQ4TDRyNFc1M3ZxUDRo?=
 =?utf-8?B?MS9OeWFtb09HcndHNy9VZUtKR3lreDV1eHFFanRwY0o2WGRxMlJaVCtFL0c3?=
 =?utf-8?B?SzFseENrcjNZbDAxb1lXbG5IaGJFOTNZMGFGaURIYlpveVgwenkyOFpaRkU5?=
 =?utf-8?B?YkN1bEpRQUlSTUp5cVY2SGxCNkljY3hYZURnMzFyMnR2bk52a0JxWWZBYzBr?=
 =?utf-8?B?VFdXd1ROdFUvL0pwY0dNeURMR2Z6aTQ1NEpRZTBvc3JlNG8vaEFIZm1qOFJU?=
 =?utf-8?B?dS8wNTdJNXBNK0VYSm9mK2xVTUJ3Q1o0L3Bac2lGU1JUeFNnZmNJSHBXeXFU?=
 =?utf-8?Q?TCDyRgbZbZq1uL9xCfawym2/w?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <86A3E77ED12DE846AF83FB301443AB85@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iNAS5/5rSCDJA7/eLIMI38jX3OAxXL3knrhoxIQT7mnBbWk6Wi2vib1b7lwTekbdnLtuXHcjG6zhLdXGndrDk/CR8VmkqUIhnFQ+2+gDBWMsIXWIqVNXxdUkIw5SOyPdtKH4rwZHDI70V0tVOCoquBw9+2VI0SAaeRxLxm5K+XVC1gcyhrRVFIBoo3EoRBRZuc2pAe4qdOKijsT5fkVCZY/262y1S9qhFH4ggWZZV1TLyJsBvuYb+LW0pHQnpt/GW4RxnBqQotwICdFtRItgYaQaYX5V3m1qwbmMDgiOepSWXX2xWOFXa11FFxBFAx0ZjbFNsOZSCbyLm5WUKynyFHrGI5t2KReA/J72j4WMxoa5MBjspJoTyq+pLU1JwmF48gJwHIDMvFBivlMTfSgY3ei/Qxb5vTOCQ2T1Lki6GUme8t0S+bu+7uYZ8OxNwrZEKj0At7jz/CrjC3mSv7Yx5YZZT/y1mhJXCCMrQkE7DXLD/eD728BSrGk9G0A30S24LB1xaNLvvhxAk8C4B+BV7lVt5ogcSttNdLiBN9FE3WfPw78juvWbBpYV/2fbQMaKWNsu2W1IYx5ujbBWeSmWA/aAKHIcQPH8+zYVQ1LYQW7rweLJNY1TYRUPgbiZu6PQQ/mpCweAz0nqwPHbDsjZizl196mSeYptXzPoMXRF+12GyYsYqdL43bdJVOQQYv27T2LVmmUBbRwTJNbvj6zHpJ0RbGhhqMXSFwVBTh+5p/Z4qlydZFFmdyibDrJq9PzRMg2gCdTRMSzTle/y/1Tk2Zov7zS7mkSSdmIDR+2FqGZoCtNqBdxA+RYX4x0Kq67vspFkDG/XFpvCcBMdsf/YKKLYTpjOhVfWUym4kDPaJeFjvp+yhdAm9y8x0M8Nt1sp
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 483637f2-f0a0-4bb9-3cd4-08db4c2a41f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2023 23:00:58.1139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8bKjnV1Iliz/+7SSLxgb3LOg9dFKKmYJX6N4kvp4QmT2UgOtsSwgXPva9kyhNApSlBRCHHj5LX1tT+QOS23unQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8902
X-Proofpoint-GUID: bWEzeskfjUU_h_AW-McaHXxY933ofidM
X-Proofpoint-ORIG-GUID: bWEzeskfjUU_h_AW-McaHXxY933ofidM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_14,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=817 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305030198
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBNYXkgMDMsIDIwMjMsIFJveSBMdW8gd3JvdGU6DQo+IEluIGNhc2VzIHdoZXJlIHRo
ZSBjb250cm9sbGVyIHNvbWVob3cgZmFpbHMgdG8gd3JpdGUgdG8gZXZlbnQgYnVmZmVyDQo+IG1l
bW9yeSAoZS5nLiBkdWUgdG8gaW5jb3JyZWN0IE1NVSBjb25maWcpLCB0aGUgZHJpdmVyIHdvdWxk
IHJlY2VpdmUNCj4gYWxsLXplcm8gZHdjMyBldmVudHMuIEhvd2V2ZXIsIHRoZSBhYm5vcm1hbCBl
dmVudCBpcyBzaWxlbnRseSBkcm9wcGVkDQo+IGFzIGEgcmVndWxhciBlcDBvdXQgZXZlbnQuDQoN
CldoZW4gaXQgZG9lcyBoYXBwZW4sIHdpbGwgdGhlc2UgcHJpbnRzIGZsb29kIHRoZSBkbWVzZyBs
b2c/DQoNCj4gQWRkIGVycm9yIGxvZ3Mgd2hlbiBhbiB1bmtub3duIGVuZHBvaW50IGV2ZW50IGlz
IHJlY2VpdmVkIHRvIGhpZ2hsaWdodA0KPiB0aGUgYW5hbW9seS4NCg0KYW5vbWFseT8NCg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogUm95IEx1byA8cm95bHVvQGdvb2dsZS5jb20+DQo+IC0tLQ0KPiAg
ZHJpdmVycy91c2IvZHdjMy9lcDAuYyAgICB8IDIgKysNCj4gIGRyaXZlcnMvdXNiL2R3YzMvZ2Fk
Z2V0LmMgfCAyICsrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZXAwLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2Vw
MC5jDQo+IGluZGV4IDk1M2I3NTJhNTA1Mi4uOGM5NTYwYTk5OTllIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL3VzYi9kd2MzL2VwMC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZXAwLmMNCj4g
QEAgLTEyMDcsNSArMTIwNyw3IEBAIHZvaWQgZHdjM19lcDBfaW50ZXJydXB0KHN0cnVjdCBkd2Mz
ICpkd2MsDQo+ICAJCQlkZXAtPmZsYWdzICY9IH5EV0MzX0VQX1RSQU5TRkVSX1NUQVJURUQ7DQo+
ICAJCX0NCj4gIAkJYnJlYWs7DQo+ICsJZGVmYXVsdDoNCj4gKwkJZGV2X2Vycihkd2MtPmRldiwg
InVua25vd24gZW5kcG9pbnQgZXZlbnQgJWRcbiIsIGV2ZW50LT5lbmRwb2ludF9ldmVudCk7DQoN
CkNhbiB3ZSBhZGQgYSBicmVhayBoZXJlPw0KDQo+ICAJfQ0KPiAgfQ0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4g
aW5kZXggYzBjYTRkMTJmOTVkLi4wNTRmNmYyOTdlMTcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
dXNiL2R3YzMvZ2FkZ2V0LmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiBA
QCAtMzgwMyw2ICszODAzLDggQEAgc3RhdGljIHZvaWQgZHdjM19lbmRwb2ludF9pbnRlcnJ1cHQo
c3RydWN0IGR3YzMgKmR3YywNCj4gIAkJYnJlYWs7DQo+ICAJY2FzZSBEV0MzX0RFUEVWVF9SWFRY
RklGT0VWVDoNCj4gIAkJYnJlYWs7DQo+ICsJZGVmYXVsdDoNCj4gKwkJZGV2X2Vycihkd2MtPmRl
diwgInVua25vd24gZW5kcG9pbnQgZXZlbnQgJWRcbiIsIGV2ZW50LT5lbmRwb2ludF9ldmVudCk7
DQoNCmFuZCBoZXJlIHRvby4NCg0KPiAgCX0NCj4gIH0NCj4gIA0KPiANCj4gYmFzZS1jb21taXQ6
IGM4YzY1NWMzNGUzMzU0NGFlYzlkNjRiNjYwODcyYWIzM2MyOWI1ZjENCj4gLS0gDQo+IDIuNDAu
MS40OTUuZ2M4MTZlMDliNTNkLWdvb2cNCj4gDQoNClRoYW5rcywNClRoaW5o
