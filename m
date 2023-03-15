Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1040D6BBD90
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbjCOTso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjCOTsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:48:35 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08424B808;
        Wed, 15 Mar 2023 12:48:03 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FGft8m010499;
        Wed, 15 Mar 2023 12:47:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=dZ8EcZsd0Lvsaf7OkoP16+IkfC98m7+niwEWEg+RMbk=;
 b=RKbxGucIHbO9QZBYEUvlgYYf+uLaACt9J4u/Ic0WyUdLrkjjwCAslF/YZisd4Vie4ygW
 JwaOS9dAhEiF78mYol3e7ODXR0aPIaqqNmOVnhYqzR1myBBXipDhHtfHHPz3YHYrHcO9
 gUTYl0JhERmsAJqpVTI2c5T6mv8muSffThXAiSS0gQmiymhiuRloe94p2DmpHaeky2UT
 L5UFjPkt913DdOAuzNt7ossPXep3oMqp1ZaMDh40a2lfRCxlatleg9tDjtM0EX1c9SPi
 GYkVEHQXTaq34HkToP4bij0gLEfYtk1YxzqSZv+o/rZn/Agt0lLZDSEfJ0So4gU7XFVS 8g== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3pb2vmd38g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 12:47:46 -0700
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D4818C05AF;
        Wed, 15 Mar 2023 19:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1678909666; bh=dZ8EcZsd0Lvsaf7OkoP16+IkfC98m7+niwEWEg+RMbk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Kjbl75L0C2tLBBnNp3w92+PSFuYJXsGvjZhKnfp2rfd6gHcN/kyB8nNLti96wT9zL
         g9/8fkgp3dEKyRpJHwDjjXoICW1x9NiKevI4GU9S0TJB/hlVy7JYzpJYgVP28Fce1k
         ChGoWu1sFBBdnuTFVhA7l/aRbicix0Jq/TP++BPaEBdiIu7cl8I6GnPve0Oaco6FGn
         d9KPXnKnhAovr0hztH3TSwUI2Tmy+rqp7gN0YKPyzrXw/cUaTissvTcqvBwd/bXtmk
         dYzFJFZaEH5izp6VhzUo9MdTPZCWFZhm8eP0nLnSfB0T8DrlmhuriDOcDT2EaYpLwS
         lNH7M8+YDE2aA==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 59D21A0091;
        Wed, 15 Mar 2023 19:47:45 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2046.outbound.protection.outlook.com [104.47.51.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 8AF024008B;
        Wed, 15 Mar 2023 19:47:44 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="v+z1tIp0";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mS5BnWOdMosc9+WTTqrPoEURm08pZlq1D1v7oXH7D9q3N5cdlOZkYNaI2wnVOu+5eLj7/2LEMkgmckKy1fC7IhT4cLYJI1M1O1xtqCn0KZSsBa6m2gxbXEte1fz/hrMrjr7p0FXuMZCfJVdjGvoT4PMsu47VALK+q8Z4Ik7s1JCqkouVTdTXC2nXLA4Og/s4UJABFeGf9q7nFs9glkfEnngbXJkwhYaMvh8C+wLNIg1tBnfcTtLkNOAdacChEBJW08LEi9WTG0qXZy8rKNCAHOk90tDHLvwCSp4CJr15sUF13RflZFlf7SZBU9/o4tj2J/leYJ0qMnrUZW/+yex7Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZ8EcZsd0Lvsaf7OkoP16+IkfC98m7+niwEWEg+RMbk=;
 b=E2G2kng9UymgTYf9VEjigWkrSGx7uTI0crsvf/FCKa/NcNptiixDhq4swHfpQofHXgbeJGnPCZwPXVM28jcpAaQ+9uCv7DAG9EdIZihyEKwqLSNGplX+P/VsedSw3rBzBufVCffO1Ilh5S/y1T0yDk4HKErgheNgJxTGjz92zeiL8+Hi9Wh5fHWIzgjkqKXiHrSj4OFBqZZM+HFzCEJpF1eWrSPGMIdKAewsBIFjZ+RSavKyR8FUpDtdzWR18J1tYo4XcUelWoSLxdcPAv4y72+qptcrAJsQSL0HKDh6QSmS/JiTKRv0rLUWTjyPcuKQnAsbKM8B+B+OQfgtNRsVrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZ8EcZsd0Lvsaf7OkoP16+IkfC98m7+niwEWEg+RMbk=;
 b=v+z1tIp0hGLSrJ2iAeDaWWZw/X0atgUJQdyU213yWJSqcAMuh4izSyTvu/cPbkAQI4/oupB6hyQZmhzuKGJbLeA0S748b8Ne0VELJRVzULCxdTLydeKWWloFob6v8QcPE/opy9ZxbLWjlGWFriuQ2bbawWQ3ldfHorZORDgiR/M=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by IA0PR12MB7724.namprd12.prod.outlook.com (2603:10b6:208:430::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Wed, 15 Mar
 2023 19:47:41 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6178.026; Wed, 15 Mar 2023
 19:47:40 +0000
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
Subject: Re: [PATCH v10 5/5] usb: gadget: f_ecm: Add suspend/resume and remote
 wakeup support
Thread-Topic: [PATCH v10 5/5] usb: gadget: f_ecm: Add suspend/resume and
 remote wakeup support
Thread-Index: AQHZV3RzS33N7pq22UWSeyeBDY77Mq78Pw+A
Date:   Wed, 15 Mar 2023 19:47:40 +0000
Message-ID: <20230315194733.yjp5ddymehxm6abl@synopsys.com>
References: <1678908551-27666-1-git-send-email-quic_eserrao@quicinc.com>
 <1678908551-27666-6-git-send-email-quic_eserrao@quicinc.com>
In-Reply-To: <1678908551-27666-6-git-send-email-quic_eserrao@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|IA0PR12MB7724:EE_
x-ms-office365-filtering-correlation-id: c76eb473-065d-4c44-28d0-08db258e22c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GtAVGyz+ZglAsupmo47Eb6rsdDwcTUuXBNXevwXtk1y7fkQU3qN1Kz8w/0FxI9FYpFLfVJeLwUfGUh6kNpQN1z170bP5/16MiY3N7TjpQyzShlfuNuFVsweKAQrTikt5pnfcKPvulzg6Z6yZoyIs7bTjHnhV7dPjJN7CKh1UjN+QjSb8uVpuGNuSeDk+b4JtMz9iSl+oKSqg5mQm71cnRfqtjK6NYwmm6uNS8pElfCSovm7FikUoSM8hGLa9R2AjeqDG5+yf9VesPpJyD7wQU/WUGrg7gFBYhOXp871aSCwk/c2apT9V9eYeEuWTk5zVPxtc1/I58OKijhEDSYmVQm7amtGYdNdq0bS2bPLsE0Tw8NeUUWzD73/Bw4EA11hZYhgizxPIGNvArhaUCoJqoz4tS3ikc0JySrm/ML3B+kuBughyuaZubgy2X2HRxYH/0DccHLaCGBxZyfIt61JlkNVrfaItkV87jHDQ05gI4pRGdQg2qXCH/JUd/6IcZQoDatddKfgsqNx6o9PfmPN+oSzIrMADIGxH519CNJXDZd0dLMunP27VntXZufrSc9qBF5Aj1cFY/lFuEWU8pMPD/nNXTbVQESf6yfRGHJrDFTZLC6xOGJWa2EfKTBcgSOWBFt7cf3NwTEJX93B9tDf6yQtwze3YKH6U85fP71Gelf5ZVjSEiXoZH85FjBWiP+CeYnVEbincRuDLS+R9Di0XgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(39860400002)(136003)(366004)(376002)(451199018)(5660300002)(36756003)(41300700001)(8676002)(83380400001)(478600001)(6512007)(6486002)(6506007)(71200400001)(26005)(1076003)(2616005)(66446008)(4326008)(38070700005)(6916009)(76116006)(66476007)(66556008)(86362001)(64756008)(66946007)(8936002)(186003)(316002)(54906003)(122000001)(2906002)(15650500001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cU9XNVZ1bjNXdVhMamc0c1pkeVZZdWxlQ3ZQUFpZUWdnMGEwNFBHcWFFTDhu?=
 =?utf-8?B?Y1BJUFBaN2RHckVGeHY2ejFRcjVSWFgrTktzdHppUVZSV1NYTlF6NllhUWdV?=
 =?utf-8?B?bjJRa1ZBV2dLdDlSNE1jVHM3eTJNcVljMHlYaDBVNmQ4eGtleDl2ZmhvbG9X?=
 =?utf-8?B?L0l1cHhIb0VVTkhOSkFHVEpUbUxNRklLb2hkcDNnR2ZYUnMwaHA2TXRzVkRO?=
 =?utf-8?B?L0hhMXI4ZWN3VHc2Uk4yY2QvblZZS2lydlJrYTBEWlNFQUxjQlpzYnZwRUVy?=
 =?utf-8?B?SURqL2dyNEtRam01OHVIRzh3UHUzcnp5UGlCRnRGTGFQakVkaW5aZDVLUXlC?=
 =?utf-8?B?MW5XbWFRVlVqczlSWkRhd2NNcFpOSFNJNzl1eXNabnAycitBWlBzZ3FIdWlk?=
 =?utf-8?B?ajhac0p0TmJCbFNlamdGcmpkUFRNMnE0dWtSU1FRVFk5K1h2NkVSUkFYVXdh?=
 =?utf-8?B?dDVVeEVRanJqT1Q4TW5TWFNOditRTSszMkxvV0NIc1YxdjJSS2x0cXBzdFNC?=
 =?utf-8?B?bWtJalAwVlo4K2k2dHY1QVdGUDNmMFRQN0FmNDVGRFdldjkrekRnMVhvbWZG?=
 =?utf-8?B?MHMzZ3dtSHdlY2xaTFRSNmRMOFJCUktGTmhZMUhYQ1dwTHdGblhKUDMzUnlY?=
 =?utf-8?B?UkQxdFRSRWxlNGs0TE1EQmJaQmV1cXlGTHBNWHVMemRpNWVRMWY3MjJ1OG9O?=
 =?utf-8?B?RSsxbHJpUnZIYVhuQnpxVmZWOFV1THZuT20xc2JBZFBFQTRJeUJ2ZDBQSVBN?=
 =?utf-8?B?b1BYMWJjNjZ5OUxGZzZtL1NobGZkYnhyVThjZ0dIRnFLSXBFTFJJQ2FHQ3VT?=
 =?utf-8?B?K1BwTTBKakZwaHVGeml1cVhsdmxqR0x4VDRoS2lHL0lqRFR4dXpVQjVpbUVJ?=
 =?utf-8?B?TWQveGlBMU0yeXRBVTdlNEQ3Ym1weXBlY00yeE1JaHRNNVZGd0lLcC9Fbm15?=
 =?utf-8?B?MDVUMUJsK0dwODdBRXdrL1pueDg3d0FJcUlEMERTUFo5WlJnNTY5Zm5BWDhy?=
 =?utf-8?B?V29SekpmUm53QUwvS3pabUxoVldCZmljRjUzVUlidGRGSnBpQklMWVNiRmgz?=
 =?utf-8?B?UDJYdzVTRGpiaU1nTUNTSkk4WjY3ZE5sVUszdVJWbEZ5NUVIWnhSeDFSNE82?=
 =?utf-8?B?Z1N5MFdpOXB5MUhpZTZXTkc2ckxtL09PejRpNzJrU0dFc3J6Y1ZLdjZvUlFM?=
 =?utf-8?B?MThZdlRCaFM0NmlpU0FzQWZncC93UGxNNWgyaTJuUE9iWGZzQWNqTG9IMFIv?=
 =?utf-8?B?aFVrVThuNS9LOTkzRUlmaHhsUGJiTzU1UGU4YmRBdmJLOXBzaTR1c25YR2tT?=
 =?utf-8?B?OVVkYXF3RnUrT3IwT1pseXcxZ0J5djFRd1NVZnNPUGlVUnZrdFlVZUN3WWJy?=
 =?utf-8?B?VWlzVUlMWi9HWmJlWFVyUmQrUzRiYkNWazYzN1Fuc2lIRTROSmNBMEdBTmZL?=
 =?utf-8?B?dWlERkQ1VWFBOWZLcm5kbDVSQUZrNlJDUkEvYkx0bCtQSVMrbVpKZFFXVWtH?=
 =?utf-8?B?QmRLdVJrUnBoekkzYk52KzlXZ1NVWXR3empEalpWc1JQZE12Vk9SekFYUWhv?=
 =?utf-8?B?RE5LVmJOdWZ6dCtnVExWcVJ2K1EwR3p6MXY1Q2pRd3FtTEZSdGxPZGt5cHcz?=
 =?utf-8?B?SlR0UHpjUFJLOVVsYjJsazlhNkNJVUtlSmdrcjJqaFJoZWlHNW9TNWEzampr?=
 =?utf-8?B?dkIxN3VTZjMwemZISGI2TFg5M29OWllnay9oYzloS2RFelVYMVpFS05RTTVH?=
 =?utf-8?B?VmZFdG1Mb2F1N3o3d21XMUlzMWJ2VElJVGk1ZDZWSVowcU1pNENHc3hER3ZQ?=
 =?utf-8?B?OWYxbEhobzVDUEphdEdjRWZNWHgwemgwbHNIZis2OFIxY0tsaGpuTnFWSk9R?=
 =?utf-8?B?TWZrVTNtTFJsNHlOQ3M5T25qR0greUVoNWhyYi9IUjhMaERtQzRhMnpRRHY2?=
 =?utf-8?B?Z0MzNVgwaXovc3FWYzZTL3FxR016eEh2MDJST3BKY2E2WGVZeW8rYkZqbmdS?=
 =?utf-8?B?UVZnMkdrWGxCM3JNa3piZmlJaDJ0eVRLTkZlYWl1ZkVOdmh3Ri9WNksxem03?=
 =?utf-8?B?dExkTDdjblU5UnlHUHBVL2VSK2srYjR4KzE5NGp3dnhwTnRNZkdjeC9hTWxV?=
 =?utf-8?Q?Jk1Rab9miUMszBm4t46//Hk8T?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <206D398398826C419510136B4B165B2B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OzwPNUC7I8ys6iiBsy66NRuoLSDD2+hOpEy1UyV/pkQF4Qvsl8FmFKd7e2T1GFAkJB34hFywLTt6cW/28MQkIsWUmM6TRfOHIcKR1w2VKS6wdHxjOakExt+OF01LSz129pT2voGWunpLXo3wz94W49AfmECZ7Mjhc/QehIAsLA82sykjqk1o7orA1lXDOMvI9RpNHGt1iBtr704ijOE9uPqeu4g6s63iPkZ6c8bG3ilyV7xWlmO0uD1zcLnl8rAilnMJrgkjseeF7kvj1T+/rCoFJf55nH3c4EY4smnujHWyhm72nuDPNF1fRAUhXK+IbRMg+3EmQSBTPxgpRMjChxxeEWNAx4SGWcbO/ebdJiC9mqkcq1wGAuWrYjz9cbvve4r+HCo6HPeIeIUrAvVbcdjtAs9plN0N8add3KH3ESMJPFUfWZDhEpJQbYAspRCeqyVAiHBnJ+DgxFoKa3BqjLVtx0uWYj7b37N/tPB+6XYQrGeLP7pmEEoFDpKLsnEhBVjdQc6YwJrwggBMyS/IcQbpCEEW23bQwkRvzSswSmF3SeXupgmyRcVWOKs48kBWCQM72+aakFTt+uJp849C+PYhUrhTnYk60QjrWo1X1XAiAbBwMlp0YGUlkLnilNsHex9AeKCLErdXA6i/TceEVUt9s+cWDsLZxFnSswgmkn5xZrnIpfajcnNWuOPSqMhUyFQW9/ApXa29ss7reBwnJBWVrorEueJfPRoyr736fT+Zy4WICBLvNleu+3UcG8g00g4aF6NhLYldcvEBk2pLoTgVwikQEV3N9Sn5L3yGe8if8aDzH1zwADPOWwXxQP6RmQG74qojZ5RzSUnJovKNkCD9B3GlWnUbQ4+4NlWsgOkqLqYHsot+eDKE5xZCpIiSLHPHGdEToPad6s5nSC+30CRqkeslQZWa+iCdqPoKG50=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c76eb473-065d-4c44-28d0-08db258e22c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2023 19:47:40.1584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QdFX1aAJL1xS78J9Vv/dWu+iWNWLdCGU812FnOTpSSZwCBFXjwgAidgAI9pQlrJBWUk5yb3kUF7Liz50yAg2BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7724
X-Proofpoint-GUID: bfCuTykj6zWcRO_NWWeXoF98pMKlvwJa
X-Proofpoint-ORIG-GUID: bfCuTykj6zWcRO_NWWeXoF98pMKlvwJa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_10,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 bulkscore=0 mlxlogscore=969 suspectscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2302240000 definitions=main-2303150165
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBNYXIgMTUsIDIwMjMsIEVsc29uIFJveSBTZXJyYW8gd3JvdGU6DQo+IFdoZW4gaG9z
dCBzZW5kcyBhIHN1c3BlbmQgbm90aWZpY2F0aW9uIHRvIHRoZSBkZXZpY2UsIGhhbmRsZQ0KPiB0
aGUgc3VzcGVuZCBjYWxsYmFja3MgaW4gdGhlIGZ1bmN0aW9uIGRyaXZlci4gRW5oYW5jZWQgc3Vw
ZXINCj4gc3BlZWQgZGV2aWNlcyBjYW4gc3VwcG9ydCBmdW5jdGlvbiBzdXNwZW5kIGZlYXR1cmUg
dG8gcHV0IHRoZQ0KPiBmdW5jdGlvbiBpbiBzdXNwZW5kIHN0YXRlLiBIYW5kbGUgZnVuY3Rpb24g
c3VzcGVuZCBjYWxsYmFjay4NCj4gDQo+IERlcGVuZGluZyBvbiB0aGUgcmVtb3RlIHdha2V1cCBj
YXBhYmlsaXR5IHRoZSBkZXZpY2UgY2FuIGVpdGhlcg0KPiB0cmlnZ2VyIGEgcmVtb3RlIHdha2V1
cCBvciB3YWl0IGZvciB0aGUgaG9zdCBpbml0aWF0ZWQgcmVzdW1lIHRvDQo+IHN0YXJ0IGRhdGEg
dHJhbnNmZXIgYWdhaW4uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBFbHNvbiBSb3kgU2VycmFvIDxx
dWljX2VzZXJyYW9AcXVpY2luYy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZ2FkZ2V0L2Z1
bmN0aW9uL2ZfZWNtLmMgICB8IDc3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
DQo+ICBkcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9ldGhlci5jIHwgNjMgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKw0KPiAgZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3VfZXRo
ZXIuaCB8ICA0ICsrDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDE0NCBpbnNlcnRpb25zKCspDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfZWNtLmMgYi9kcml2
ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl9lY20uYw0KPiBpbmRleCBhN2FiMzBlLi5mZWEwN2Fi
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl9lY20uYw0KPiAr
KysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl9lY20uYw0KPiBAQCAtNjMzLDYgKzYz
Myw4IEBAIHN0YXRpYyB2b2lkIGVjbV9kaXNhYmxlKHN0cnVjdCB1c2JfZnVuY3Rpb24gKmYpDQo+
ICANCj4gIAl1c2JfZXBfZGlzYWJsZShlY20tPm5vdGlmeSk7DQo+ICAJZWNtLT5ub3RpZnktPmRl
c2MgPSBOVUxMOw0KPiArCWYtPmZ1bmNfc3VzcGVuZGVkID0gZmFsc2U7DQo+ICsJZi0+ZnVuY193
YWtldXBfYXJtZWQgPSBmYWxzZTsNCj4gIH0NCj4gIA0KPiAgLyotLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKi8N
Cj4gQEAgLTg4NSw2ICs4ODcsNzcgQEAgc3RhdGljIHN0cnVjdCB1c2JfZnVuY3Rpb25faW5zdGFu
Y2UgKmVjbV9hbGxvY19pbnN0KHZvaWQpDQo+ICAJcmV0dXJuICZvcHRzLT5mdW5jX2luc3Q7DQo+
ICB9DQo+ICANCj4gK3N0YXRpYyB2b2lkIGVjbV9zdXNwZW5kKHN0cnVjdCB1c2JfZnVuY3Rpb24g
KmYpDQo+ICt7DQo+ICsJc3RydWN0IGZfZWNtICplY20gPSBmdW5jX3RvX2VjbShmKTsNCj4gKwlz
dHJ1Y3QgdXNiX2NvbXBvc2l0ZV9kZXYgKmNkZXYgPSBlY20tPnBvcnQuZnVuYy5jb25maWctPmNk
ZXY7DQo+ICsNCj4gKwlpZiAoZi0+ZnVuY19zdXNwZW5kZWQpIHsNCj4gKwkJREJHKGNkZXYsICJG
dW5jdGlvbiBhbHJlYWR5IHN1c3BlbmRlZFxuIik7DQo+ICsJCXJldHVybjsNCj4gKwl9DQo+ICsN
Cj4gKwlEQkcoY2RldiwgIkVDTSBTdXNwZW5kXG4iKTsNCj4gKw0KPiArCWdldGhlcl9zdXNwZW5k
KCZlY20tPnBvcnQpOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgdm9pZCBlY21fcmVzdW1lKHN0cnVj
dCB1c2JfZnVuY3Rpb24gKmYpDQo+ICt7DQo+ICsJc3RydWN0IGZfZWNtICplY20gPSBmdW5jX3Rv
X2VjbShmKTsNCj4gKwlzdHJ1Y3QgdXNiX2NvbXBvc2l0ZV9kZXYgKmNkZXYgPSBlY20tPnBvcnQu
ZnVuYy5jb25maWctPmNkZXY7DQo+ICsNCj4gKwkvKg0KPiArCSAqIElmIHRoZSBmdW5jdGlvbiBp
cyBpbiBVU0IzIEZ1bmN0aW9uIFN1c3BlbmQgc3RhdGUsIHJlc3VtZSBpcw0KPiArCSAqIGNhbmNl
bGVkLiBJbiB0aGlzIGNhc2UgcmVzdW1lIGlzIGRvbmUgYnkgYSBGdW5jdGlvbiBSZXN1bWUgcmVx
dWVzdC4NCj4gKwkgKi8NCj4gKwlpZiAoZi0+ZnVuY19zdXNwZW5kZWQpDQo+ICsJCXJldHVybjsN
Cj4gKw0KPiArCURCRyhjZGV2LCAiRUNNIFJlc3VtZVxuIik7DQo+ICsNCj4gKwlnZXRoZXJfcmVz
dW1lKCZlY20tPnBvcnQpOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW50IGVjbV9nZXRfc3RhdHVz
KHN0cnVjdCB1c2JfZnVuY3Rpb24gKmYpDQo+ICt7DQo+ICsJc3RydWN0IHVzYl9jb25maWd1cmF0
aW9uICpjID0gZi0+Y29uZmlnOw0KPiArDQo+ICsJLyogRDAgYW5kIEQxIGJpdCBzZXQgdG8gMCBp
ZiBkZXZpY2UgaXMgbm90IHdha2V1cCBjYXBhYmxlICovDQo+ICsJaWYgKCEoVVNCX0NPTkZJR19B
VFRfV0FLRVVQICYgYy0+Ym1BdHRyaWJ1dGVzKSkNCj4gKwkJcmV0dXJuIDA7DQo+ICsNCj4gKwly
ZXR1cm4gKGYtPmZ1bmNfd2FrZXVwX2FybWVkID8gVVNCX0lOVFJGX1NUQVRfRlVOQ19SVyA6IDAp
IHwNCj4gKwkJVVNCX0lOVFJGX1NUQVRfRlVOQ19SV19DQVA7DQo+ICt9DQo+ICsNCj4gK3N0YXRp
YyBpbnQgZWNtX2Z1bmNfc3VzcGVuZChzdHJ1Y3QgdXNiX2Z1bmN0aW9uICpmLCB1OCBvcHRpb25z
KQ0KPiArew0KPiArCXN0cnVjdCB1c2JfY29uZmlndXJhdGlvbiAqYyA9IGYtPmNvbmZpZzsNCj4g
Kw0KPiArCURCRyhjLT5jZGV2LCAiZnVuYyBzdXNwICV1IGNtZFxuIiwgb3B0aW9ucyk7DQo+ICsN
Cj4gKwkvKiBSZXNwb25kIHdpdGggbmVnYXRpdmUgZXJybm8gaWYgcmVxdWVzdCBpcyBub3Qgc3Vw
cG9ydGVkICovDQo+ICsJaWYgKCEoVVNCX0NPTkZJR19BVFRfV0FLRVVQICYgYy0+Ym1BdHRyaWJ1
dGVzKSkNCj4gKwkJcmV0dXJuIC1FSU5WQUw7DQoNCldlIG9ubHkgbmVlZCB0byByZXR1cm4gZWFy
bHkgaWYgdGhlIGhvc3QgdHJpZXMgdG8gZW5hYmxlIHJlbW90ZSB3YWtlDQp3aGlsZSB0aGUgZGV2
aWNlIGlzbid0IGNhcGFibGUgb2YgaXQ6DQoNCgl3YWtldXBfc2VsID0gISEob3B0aW9ucyAmIChV
U0JfSU5UUkZfRlVOQ19TVVNQRU5EX1JXID4+IDgpKTsNCglpZiAod2FrZXVwX3NlbCAmJiAhKFVT
Ql9DT05GSUdfQVRUX1dBS0VVUCAmIGMtPmJtQXR0cmlidXRlcykpDQoJCXJldHVybiAtRUlOVkFM
Ow0KDQoJZi0+ZnVuY193YWtldXBfYXJtZWQgPSB3YWtldXBfc2VsOw0KDQpCUiwNClRoaW5oDQoN
Cj4gKw0KPiArCWYtPmZ1bmNfd2FrZXVwX2FybWVkID0gISEob3B0aW9ucyAmIChVU0JfSU5UUkZf
RlVOQ19TVVNQRU5EX1JXID4+IDgpKTsNCj4gKw0KPiArCWlmIChvcHRpb25zICYgKFVTQl9JTlRS
Rl9GVU5DX1NVU1BFTkRfTFAgPj4gOCkpIHsNCj4gKwkJaWYgKCFmLT5mdW5jX3N1c3BlbmRlZCkg
ew0KPiArCQkJZWNtX3N1c3BlbmQoZik7DQo+ICsJCQlmLT5mdW5jX3N1c3BlbmRlZCA9IHRydWU7
DQo+ICsJCX0NCj4gKwl9IGVsc2Ugew0KPiArCQlpZiAoZi0+ZnVuY19zdXNwZW5kZWQpIHsNCj4g
KwkJCWYtPmZ1bmNfc3VzcGVuZGVkID0gZmFsc2U7DQo+ICsJCQllY21fcmVzdW1lKGYpOw0KPiAr
CQl9DQo+ICsJfQ0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCiA=
