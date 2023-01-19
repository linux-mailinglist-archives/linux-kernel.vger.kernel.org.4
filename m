Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCF7672DAC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 01:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjASArZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 19:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjASArX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 19:47:23 -0500
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C77613C3;
        Wed, 18 Jan 2023 16:47:22 -0800 (PST)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30IJqbMT001286;
        Wed, 18 Jan 2023 16:47:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=6ATbbIQNHEbP8Sok26I4bqdXpg3A4wJXDHKUOIV1TJY=;
 b=VrcKrgQPsP9FjWAeHS/N+7vVGNCBIAJJjkTITC3xpzs6J/XY/eRfAR1B8vp6l7gM/qzv
 CIOSOeJRla/8f3wjfaa9GqU3OMAQMESlr5UZghsFl80v5sKbgqDuGv1vuHZqVHatWyJ7
 V/tcaRqSKcyqESoutVHWyMKg4DfpF5rSYGLXOe8hPmPR8yMrq2zajO0jSVDhOJzQiz1s
 x3K74MXh7xIoXFgdi8EIe+lxS+V3p7+RgSrA/vTdNpBiKNmLPGX+dasysvWJ58F7n0fB
 UC8gWpOXvrDnAuwJHxhxf/sGa+HH6jThTdfFGRudl90gEJU6xPEx3YcoXtrxLpPoB2Bz EQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3n3v71sc14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 16:47:08 -0800
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1EC83C2325;
        Thu, 19 Jan 2023 00:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1674089226; bh=6ATbbIQNHEbP8Sok26I4bqdXpg3A4wJXDHKUOIV1TJY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=YNTMcEZqqQYEFzr0NNGdgAGQ/kFGi4ksXfqB8TwGiYyZ+F2IN1oiQxo5HmP7IEnE5
         ueRSkUxBED64jD57Kglc6uyX63FMaNpEloQzU5fL3g/aRNRAKp/D+lxPMXB2sEXqdb
         6VwYsKS30xcq1evZrQyWfwUpSws6wDt1jF+RRwKbetaJMQAyuCfcAwWdqqjrUZS3fU
         yoi9gwe9V/DPF5dlvSGMi48MLjWjYZOgOrKY0dd9D6k15PTi7ktkjiStmzr9hR1M1e
         XxmxpsIMnv/dqo1i1RYKUqXrx30xm15a1jTRpOCM3zCWTzHtrdYeHb4S36/x4CFM1T
         phw8p56USIflA==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 4E023A0068;
        Thu, 19 Jan 2023 00:47:03 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id BB8BB4004F;
        Thu, 19 Jan 2023 00:47:01 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="v9VHCv2I";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQcNRkuFNftEWkSfoVZ+dSTECiIGRhpOBJxF8AATd7av65zKNDJnR4xV8bi1BSedCmkFG6qT2xLY7mZn+w4+I505i87bfzVLIM8b4ebcQwOG/nETBC01LjfeQFdmvQ01oDV5PaB8MOf4kKsAjkmIA+PaIdYT3gOoeG8Q0VajF43DyWbQ6GezRuDUvBj+DV7zQbiM/AHH+57YwftnLksqBGSt9KOl/dLuKY7POrJe8ee+HANi+df13M4rRLfUZTGk9shqCsW33syU/IhCyohl4HDtRur1Hgoq2r9BmGWxowamQXDvp75ZAhrL/f5G/7bpoG/Gd4nN3yTHvWMB/VonrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ATbbIQNHEbP8Sok26I4bqdXpg3A4wJXDHKUOIV1TJY=;
 b=k3MNxpDrOOOCcWlidkvOMtmSaGZLQf184nKpPILTG1NaMFNiEUSeX5nRbnWxuS0TvkDmZwdBcNNTmFkYf3GUAheZv9MYpWXKxnAV5mC+f3IRSBExBwIwERYblHbEkXdLMSOTTPFLGiGkoeYeyLWz5sNVj9chAPD09nksqx/IdaOZmc+ppZ81EZ7YbVA8tJDTI+pAzHyC0DqxmK/U8ic4KUjJakDJNYR+GL3htirroo2tQKaFaLzzXgfhNo5HxQF6QsJO+yulKp2RQOc5kqNVdzPtwxcseo57nDayfp92NerQvYHayHdng9RdFA0JRDfM8KOXNSFpMWILIl0fqNWfEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ATbbIQNHEbP8Sok26I4bqdXpg3A4wJXDHKUOIV1TJY=;
 b=v9VHCv2I/K2+XTdiC3Y/V2WpUiqUGdHUPey8bnW+jT6xdvZaSSnJqkZOXBqwe3Xx7AhUcxehlo69zLnNQoCLCObE/zS+Gqp270vqWYTNcFJwkN5QdtPPzBAFgsG00lifzfa1nC/H0vwTMFoV499nqU+waV5lxbSYSHNzNZm+7ws=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by PH0PR12MB8127.namprd12.prod.outlook.com (2603:10b6:510:292::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 19 Jan
 2023 00:46:56 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::e395:902b:2e90:b7ee]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::e395:902b:2e90:b7ee%4]) with mapi id 15.20.5986.018; Thu, 19 Jan 2023
 00:46:56 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Rob Herring <robh@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Johan Jonker <jbx6244@gmail.com>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: snps,dwc3: Allow power-domains
 property
Thread-Topic: [PATCH v2 1/2] dt-bindings: usb: snps,dwc3: Allow power-domains
 property
Thread-Index: AQHZK3NpFU2d7nrrVkSigYyIDiZPAq6k6CYA
Date:   Thu, 19 Jan 2023 00:46:56 +0000
Message-ID: <20230119004654.ryti5iwelmnk3otg@synopsys.com>
References: <20230118193056.673514-1-robh@kernel.org>
In-Reply-To: <20230118193056.673514-1-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|PH0PR12MB8127:EE_
x-ms-office365-filtering-correlation-id: 75621869-258a-489b-181c-08daf9b6aa3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G7i3S3Ugp9hWS88vMiydeuP0o5ayOITcNmOaV6BMJzyl/JbNGwaRwBzfUF3eZaYwQmzQmmGrLHt7POHtybfn1njPeTmJ24Ctr3tCm9+X1uOpld8ZvXHtRuoGRQ+Y9hh7qHhjDUJ/0vo1zhu2OyHzXd+GQnDysC9ThXA//wweoAG2K6H/TmjLeZOFR6X6W+zGO7o83Ae0ZOE9JznVfJesQObJT4I6pjWZsvkM02luMGhdDwPIkFTLmGdQ0PQr56qtJ2cTnMIeLPPS/JeRU4TRPT+9RyDdZDrXJXr6jf+OmvicpyWa6XdneDafBDJMXKXklXG9GmCEqODfXzLBWPsf+8fQzYMlCtuncYxVOsaADvHeUIGFhwbE2mVQpxjO6OCndCnR1+oYvD4q2kGDYw++ifRZdbwnjScckZuAKk9BSESkTiDmOZdcAvemUSHGacvsjdxqBKahTDSxVQzMycE0EGpNO7xgP3MHasdQyuFlJKr+rAs5gcx4n5UcHOiiyfbuCkRcOc7j1/Knzt4xtFEknu/n4EVqvh7QYRX3zeT91EP1F1THHtpUf/ztu3BdGqMiLGxaFWsLdVWO7dnR/WA0rYdYpQt0VGI9SHEL8p0OBSbwJNQ4+dsIGiwojty91EKEdlM37yIQtRJu3c7fVRjvylytf8nuRTgd6dyqpxYtPYChREMpS5a3bBt3Swml056Ip/bBiu4wk64ZNMxBvxPGxg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199015)(66476007)(38100700002)(83380400001)(122000001)(66446008)(38070700005)(8676002)(66946007)(5660300002)(86362001)(6916009)(7416002)(4326008)(2906002)(64756008)(76116006)(66556008)(41300700001)(186003)(6506007)(6512007)(2616005)(1076003)(26005)(54906003)(316002)(478600001)(6486002)(71200400001)(8936002)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cE5oUGcwalA0VmFraWI0ckFnRUl4WEl3TGZlVU9jRDg1ZGRhU0RmTVptYTY5?=
 =?utf-8?B?ZGRpNE9RSVNWVjJDK0prdUc5cGgrNkxEYlg3K2lzMkNVbW9FM1RhNFFvTXZX?=
 =?utf-8?B?S284Q0xENG9mL1BqVWZMNm5YbE5wUlVNckphMXY4c1JnN0s2Qm5uSlZ6SG9O?=
 =?utf-8?B?QVdHZkRjR3RxZTZoci9KbnVQbU54VndLSi9PZWgvRkt1NWFGNFMyY2dqZi9o?=
 =?utf-8?B?Vk1WTmE1UEsyOEl4cVVRcmZsOHIxMFdaYjRlenU1OXBaY3YxVG53ank2T3E3?=
 =?utf-8?B?elVpRmR0NjUrVTNRdjgyeEFtWXAxWVE1SlphZmdWeUxnTlBGNTlaS2hFbkZi?=
 =?utf-8?B?TklrV0ZFYTBxTjYycEdjUHd2aFg5M3EwWDZvdUxISUxqQlJFZGN0NUVGb0dh?=
 =?utf-8?B?ZXViQTlFTGtMQTJEbkFzeTFwVTQya0V4NXFoUVdrOE5GdEJkQVFaUW4wNUZs?=
 =?utf-8?B?OUJsUkw5eWRkaGpjaTF5Z05BRWowZFVTeHFhdVoxOEZXMEduSFZXQ0ljOWli?=
 =?utf-8?B?Z1ZqSnZaOWM3ejVQSm0yOHEzTTc0Rkp4RHliSDRoMkVlcVZVRUgzdjVUMTVo?=
 =?utf-8?B?aER6QnBKU2w4TkRGOGt4Y0I1T3ZlUE9Jb3FVQ0xQbUxKVHcwR2FFZXY3Z0l3?=
 =?utf-8?B?SWJpUExCRS94a0VTM2VtM25nMmVBdG5KQ2lZemE2MVViTUJOZitMOUF0SkVS?=
 =?utf-8?B?UjQxbnNuQVhjVHRpOG0rRCthQ3QyNkxnWkxLUXFyTVJ4bVY2OC9iVGRqRUJu?=
 =?utf-8?B?ZElLTWN0WWMwSmhJYUFGMFowMFkyNFppR21XWTdMdjZrdi9NbC9TMXFWb3kx?=
 =?utf-8?B?WlVnZkRKNGZQTXJCWVBVc3RiQy9vaG9kZ3V6V0Z5a2thSjZCbm1ZZ1U3N2hE?=
 =?utf-8?B?RzlwQlg5SmhUcUNlV2sveGFRazVlT2NRa0o3U2xsMVBvbTF2bWtxK1NrUkZB?=
 =?utf-8?B?ZTRuQnF0dGhDMTVsTzZ4ZWIwdit2bE9hNS9FVk5Pc2U0UmE3NWhXYnpxamtI?=
 =?utf-8?B?RlNmNVdDYm1VUlZEeE5SL3RURmJ3bDF2WFA5VmZGL0ZnTkNlQlYraDlCNWEw?=
 =?utf-8?B?aFpDQm96aFVBSTBzdTY1dHJmYmZVRjBsWlpWNGIwYU9YMlNHK01LeEpDT0Jx?=
 =?utf-8?B?M25xMFRoUzZjMTcwYXFlcGNQSForUnZQSjBzQktOWjBWQWVSY21GQVk4TlE2?=
 =?utf-8?B?ZkFKbkh2WnlyMXIrY0F3UEhsUVpUYmo0SDQxbk5NRzdNSmtXcE9LdjQ0aEsy?=
 =?utf-8?B?YU5LYWZSZ3J5NXhjMDNnQU5EVkpkd0pjeEtsSzZGVjVBTnJRSmRITEd2R1ly?=
 =?utf-8?B?aUlzakdKWW1ZY2R4ZFhjYUtkS3JWY2JZNzNCMlZ2N2tDd2h4UDRIa09wNjkx?=
 =?utf-8?B?UW9NUnczV1FsTnRJOGczYm9ESUJTU3FzRUoxNy9wYS8yZDljTkVYWTNPNjZy?=
 =?utf-8?B?ak5RQ0g1Y1kvRFp5Y1h0TXBEZGtDWDZpanloL2lzanA5aHZML2tCQzVVNm0w?=
 =?utf-8?B?dThhWFZoWUJEVDVBM3JDZGo5YzhkNDlxcmxJL3RqcUgxR3dtV1FyM25rSEg1?=
 =?utf-8?B?eDdqTkIyZ1J6MHZwdHp1STlFdGJwM3dsTWZaaWlWdEE1RE1WU1JjWVlJcWVX?=
 =?utf-8?B?L3NiODYvb0Q4K0lIZng1RjgydGJucUNQQXRXc2VvNW5kWjhLdDNMbUVPYzNM?=
 =?utf-8?B?T0N5MVhEc0duN3dUbmJFVk01eXhJb3N4VGEvOGlJd2ptVmlrOFM5VFJKeUhD?=
 =?utf-8?B?bUxMaW9UcmVodENzVktDUDFNdVNzYlF1bzZ6UTVBcExkNFVVS3kycXF1cFlD?=
 =?utf-8?B?RXVCU2hFSExxenNKYng4UFJyRTlsOVRMZEUyMEZVU0N0UWdZNk96ZG5XaGRk?=
 =?utf-8?B?VjAyYTRXS2x0M2hmbkdCRC84WWc0WnlXZnVnUlpOOFJQalBCNnJtRHYzUk9s?=
 =?utf-8?B?R282RGJHUVprdk9sQWZ1TmlsQVI2alZ2M3pxU1hKTzdrSmszOW1YdW1WTEdJ?=
 =?utf-8?B?V2Vta2dNUGNGa1dGVTVqSUhLMzRNYVlGdlBqU3VDQ1JpdGR5RVdJL1AvQVdF?=
 =?utf-8?B?NDRUSVU1Mmp6cUVRcDU4OTQ5UzA0eWxtR3VsSFFNc3FCYk5wdlhJdk9IVHUv?=
 =?utf-8?B?dkV3MDNhNlVtWHlMSVptWDdna0ZvOVd0ZzR2MWE4V3VlZkhGZHMrVG13VDNp?=
 =?utf-8?B?VHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <619D4AF338E1C346A4528CAD882CF6A9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?eituU2dzSm5uUEtxL3hpVEtlc1Y5NndidGNJTTdFNHo2K3FVVThTMlVPY0VG?=
 =?utf-8?B?YS9Cbk1qbGdiWEVINGRhMmVobENFc0xhcjd4YThQcVNuWWp3TUJIV0U2Vytu?=
 =?utf-8?B?RXdjakp3Q244ZEs3RkhJMWVjNTQ5cEtjSktWN21odFh0SDVYbHRqVnBYUHFy?=
 =?utf-8?B?T2NYRWdMTXFiTmpVZm9OQ0d0aGZCVVdZNkJkSTZpMkxiU1lYd1d3eU5YQ241?=
 =?utf-8?B?bjN0TThlakgycHhCblltU2V1eDErMUo0TUx3d3BmY2tzTjZUbUZIQ3Vwd3Nh?=
 =?utf-8?B?TEE5Wmk5SzZrSFVNTkVlVDJjTFBhSGNZSU5NRHk2SWNmaUZEeXllMXZPR2Uv?=
 =?utf-8?B?UUQzTGt1aEErWEZUaTRWM0dWSzJCaVk4ZVoyR2svRnY4MkVCV2tXSTBtdmlp?=
 =?utf-8?B?b0V2VjhUL0VFTkpTZkMxQkxDRThVKzJkK05zNGRCRHo4L29IWi9KNlRTRDNC?=
 =?utf-8?B?L2o0TlZnUlBGekhQWVpKVVlsb0xDOTBwYTZJVk5GZXdhS0tvN0dDamJvek1H?=
 =?utf-8?B?SkZaYmxJQVBrZk10d1I1enNVd1NBZGZQVnVZMElqd2hwTEd0ZlJmTkRqVVc2?=
 =?utf-8?B?RzdSSEp5eEZuWWFqUnM5ak1vUkpxc0ZqUWJnTUViU0lCaWdlYXV4V0VOTVRY?=
 =?utf-8?B?Wko2dTNDeGhiZjRKczlvZE5qMkxKUmRqdzJiUmlJY25HUjRoWVRldU1Yekc2?=
 =?utf-8?B?MmJ6aTJzVFVjZkJtYkhSS0l1cWI2c283YjcvVS8vVC9SV2c2ODkyckVHUG9E?=
 =?utf-8?B?cFBWWUNJdENTUDBQLzR0RWlNMVh6d1VzbFEyaVRwc215aFYxbTNBTVVDWGtj?=
 =?utf-8?B?MUhXV3h1RUwxRnJZa2s4T2ZZRElpRnFyV01QVGQ4VEVkckRXTEpucnJXVURC?=
 =?utf-8?B?ZnJVQk5RVVlGaTdKNk9YUVpIZ0FEVlNQaGJUd0FQSmVFeXhHaEt3OURZTWdV?=
 =?utf-8?B?eE1FVE40RVRHNkN5RHdJZXYwK0tnWGVVdXovL3lHdjhGNXJsM0JwRjZlOUFz?=
 =?utf-8?B?WGhvRnQ2empQdXdPa2g4eEszSjdHSUhlSnJMNGM1cFdHVjlaaDR1WUIwQlpV?=
 =?utf-8?B?N0ozMnQrV2FsZXJUOGsvNVYrclNSVEhuV3JoaW15L0JXOEZOZUFBQmNrRXhm?=
 =?utf-8?B?S1gxV3lqUkc2MlhpM3FQWWpXZE5JbFNIc01DVEFNdTZaYTVqNU5vTnJaTFV5?=
 =?utf-8?B?SVBxSzVBZ2UwVEZUcnVzeXpDaWNRSGhieTNqZGpLU2FNNG5NWkhUZXFvTUNL?=
 =?utf-8?B?ZVB1S3BHTlUxZjUweGo4V215UWNxT29MOHU4dHJjVXZab0NENHBYSmxYbGx2?=
 =?utf-8?B?QWxYY0lpbURHRnh5T1htVkVuZTliQk5Jc0tYaUVOdmF0NjJyOTB1dkJ4ZTlq?=
 =?utf-8?B?bUo1K1VLWFY3UXc9PQ==?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75621869-258a-489b-181c-08daf9b6aa3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2023 00:46:56.1019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FwT57IBr5689v2exP+wQt2Zxb+W8TZf64kk80ztWnE4JM8ENSdypzzONCZD3qQzw2fNbCuo5dagROSMgzF+2qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8127
X-Proofpoint-GUID: 1KwrC1DYjZtIX6GFEeaNqJ9kHLVLCmnC
X-Proofpoint-ORIG-GUID: 1KwrC1DYjZtIX6GFEeaNqJ9kHLVLCmnC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0
 bulkscore=0 clxscore=1011 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301190001
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBKYW4gMTgsIDIwMjMsIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiBUaGUgUm9ja2NoaXAg
UkszMzk5IERXQzMgbm9kZSBoYXMgJ3Bvd2VyLWRvbWFpbnMnIHByb3BlcnR5IHdoaWNoIGlzbid0
DQo+IGFsbG93ZWQgYnkgdGhlIHNjaGVtYToNCj4gDQo+IHVzYkBmZTkwMDAwMDogVW5ldmFsdWF0
ZWQgcHJvcGVydGllcyBhcmUgbm90IGFsbG93ZWQgKCdwb3dlci1kb21haW5zJyB3YXMgdW5leHBl
Y3RlZCkNCj4gDQo+IEFsbG93IERXQzMgbm9kZXMgdG8gaGF2ZSBhIHBvd2VyLWRvbWFpbnMgZW50
cnkuIFdlIGNvdWxkIGluc3RlYWQgbW92ZQ0KPiB0aGUgcG93ZXItZG9tYWlucyBwcm9wZXJ0eSB0
byB0aGUgcGFyZW50IHdyYXBwZXIgbm9kZSwgYnV0IHRoZSBjb3VsZCBiZQ0KPiBhbiBBQkkgYnJl
YWsgKExpbnV4IHNob3VsZG4ndCBjYXJlKS4gQWxzbywgd2UgZG9uJ3Qgd2FudCB0byBlbmNvdXJh
Z2UNCj4gdGhlIHBhdHRlcm4gb2Ygd3JhcHBlciBub2RlcyBqdXN0IHRvIGRlZmluZSByZXNvdXJj
ZXMgc3VjaCBhcyBjbG9ja3MsDQo+IHJlc2V0cywgcG93ZXItZG9tYWlucywgZXRjLiB3aGVuIG5v
dCBuZWNlc3NhcnkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJu
ZWwub3JnPg0KPiAtLS0NCj4gdjI6DQo+ICAtIEFsbG93IDIgcG93ZXIgZG9tYWlucyBhbmQgZXhw
bGFpbiB3aGF0IHRoZXkgYXJlDQo+IC0tLQ0KPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3VzYi9zbnBzLGR3YzMueWFtbCB8IDEwICsrKysrKysrKysNCj4gIDEgZmlsZSBjaGFu
Z2VkLCAxMCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9zbnBzLGR3YzMueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy91c2Ivc25wcyxkd2MzLnlhbWwNCj4gaW5kZXggNmQ3ODA0OGM0NjEz
Li5iZTM2OTU2YWY1M2IgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy91c2Ivc25wcyxkd2MzLnlhbWwNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3VzYi9zbnBzLGR3YzMueWFtbA0KPiBAQCAtOTEsNiArOTEsMTYgQEAgcHJv
cGVydGllczoNCj4gICAgICAgICAgLSB1c2IyLXBoeQ0KPiAgICAgICAgICAtIHVzYjMtcGh5DQo+
ICANCj4gKyAgcG93ZXItZG9tYWluczoNCj4gKyAgICBkZXNjcmlwdGlvbjoNCj4gKyAgICAgIFRo
ZSBEV0MzIGhhcyAyIHBvd2VyLWRvbWFpbnMuIFRoZSBwb3dlciBtYW5hZ2VtZW50IHVuaXQgKFBN
VSkgYW5kDQo+ICsgICAgICBldmVyeXRoaW5nIGVsc2UuIFRoZSBQTVUgaXMgdHlwaWNhbGx5IGFs
d2F5cyBwb3dlcmVkIGFuZCBtYXkgbm90IGhhdmUgYW4NCj4gKyAgICAgIGVudHJ5Lg0KPiArICAg
IG1pbkl0ZW1zOiAxDQo+ICsgICAgaXRlbXM6DQo+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBDb3Jl
DQo+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBQb3dlciBtYW5hZ2VtZW50IHVuaXQNCj4gKw0KPiAg
ICByZXNldHM6DQo+ICAgICAgbWluSXRlbXM6IDENCj4gIA0KPiAtLSANCj4gMi4zOS4wDQo+IA0K
DQpSZXZpZXdlZC1ieTogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0K
DQpUaGFua3MsDQpUaGluaA==
