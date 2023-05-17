Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0578705DFB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 05:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjEQDWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 23:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbjEQDWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 23:22:01 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB3F2689;
        Tue, 16 May 2023 20:21:54 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34H1K2q3025765;
        Tue, 16 May 2023 20:21:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=hyXT3NCcZd6uiYy7lVM0NiETl/53m3yXVQalNwGkCF0=;
 b=O/wP6SNgd7tPLS1DtLzzKQZpuGogtPn3xiBidrFl6CAEpZymLSmDzvNWbzwho+4Vlkuc
 0dViNkRPunzFoo1zuHF7gRkgWFn/MffyDxRMur4ExMy2G4wPhQtTrmnjGAGod2z57KLS
 HnFu32YXa0RRBn/vUN5fzaLcXQTBOmjT8HR0dxs/VZYZwDlb8xyCcNib1HvFMK2DHxOS
 +DOZ/YauYXpu43Juuy3MatwsMZj8bAycqSFid52LSGx9P0lfM9khtUYW0sPoglaehjB4
 i36sPc+XnpLuDiWtjhK8zlD6coKrPn7zXlDUaziZdWNRhLZ8aSXNdyqlfP4BMgyMZyAc XA== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3qj9t4s3vp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 20:21:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1684293692; bh=hyXT3NCcZd6uiYy7lVM0NiETl/53m3yXVQalNwGkCF0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=WtMTt3SFJ2msHJ1o9RcxispvrYhAB4Q1Y67DwiYEuzCnNcwA0SXtNQlGL1gn7qxpC
         9b3EMvsB8vqebQ//ywvGEUjCl5ccvMKItfT840ukVzu/ooL3qy/tI5WpnixbwR+aDa
         tQWgG+0cDan+DMIHWf6lU/OsPOW71vIwZ7VN/aAouS4ZYUAo0xpxK0m1qMA2dqqHBe
         s81MfJekPptYbsnN/EYuD9gS+kT9BWXmgmSpgyT2x/1MqqdFjQCOElSz+PxwE2nNR+
         G22XNU1/xCg9hLe7PyKjH6u1ibRgNJXoIAh8R/UaBtgpceRbC1Ie3O9Q1MORBZLaYe
         3ZIChuU+jPZlA==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 557A44048F;
        Wed, 17 May 2023 03:21:31 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 3B453A0070;
        Wed, 17 May 2023 03:21:30 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=ZV9C4OtT;
        dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 923F040614;
        Wed, 17 May 2023 03:21:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1eVp/k4nJ9Hj5qZZ0u5DSkz/ggcZaUpVmKHmG6/ObAut4/aQtqmrcwU2BiuNbD3DLXTdLYfVsPP0mGMJeeEbJZ8YThBnzFJ1EWkdQFwtc4fXbokQ1cpwHGen16C/zPqswnrpqJEShO8P3zJCM3V0vPwLbHHepjoSj+7TFKXc3NVlE7TDbeIsNILV6Epmlw7X910C6QqIknfDxN8CFv5bSY/xDFyR8t25aISIoxwcU4VKXPhTqyJBN8vRfFno9Jm1ioNg1bF1bjy63Sgis7NuCNALaX57Z7mwBGjQZrOLLhyrV48oAKMNveB/UMxgQ0yWtEXbpXj1jueqXjO9eo0RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyXT3NCcZd6uiYy7lVM0NiETl/53m3yXVQalNwGkCF0=;
 b=RToZwTMvBrPol2LVrCN7hCpDjiY3cUKmlhxNbRq8rLn/mo4q7pbR6ygPD3N/4zxgFUQpHw6zpn/KfOfYBr82qANpEq1EE8Un29Na46VNdMrTgGBt0mjZkQBVzp8tuWNmv26+TKH5Pu2wMozGQKVqwPbkUwYesuZBXC+swl8210Uvby3mu0YHepI+BUuGAxXxNL9NJj7nql4P/T3TYzl1SNJF4qHzmfBd6Tbmmx0lguI4a9A4JX2hJynUWlWmSFMePjjGvfm0bk2g5LsVWvqEoQZTCGXift116OpJ/kc/Wip/L+FYKGVaLN7rXuLjqFdy+gOCWrMHh6y0eXQxWcvhHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyXT3NCcZd6uiYy7lVM0NiETl/53m3yXVQalNwGkCF0=;
 b=ZV9C4OtT8jCqxTV5Oi/JtUmuFz6CiRHeZLzxmlfqsxPannHfSEK7YrIAzLpv8cH5tDTF0uIjkizth91r9G0NljiljT5573D1/2io+jtGJcDx9SIT1snpuXYxmfCne+K2HSlfpFG0o8DLlxkByWqXNPBysErQWuCLEWjCxEu9zR8=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SJ0PR12MB5440.namprd12.prod.outlook.com (2603:10b6:a03:3ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 03:21:25 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3400:81ff:f191:b312]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3400:81ff:f191:b312%5]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 03:21:24 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
CC:     Johan Hovold <johan@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "quic_pkondeti@quicinc.com" <quic_pkondeti@quicinc.com>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_harshq@quicinc.com" <quic_harshq@quicinc.com>,
        "ahalaney@redhat.com" <ahalaney@redhat.com>
Subject: Re: [PATCH v8 3/9] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Thread-Topic: [PATCH v8 3/9] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Thread-Index: AQHZhifwmS3nkBg8RUifIdaehLDgz69c0rwAgAAvrwCAAMucgIAAAvoA
Date:   Wed, 17 May 2023 03:21:24 +0000
Message-ID: <20230517032124.rdh7ehnair3wjuvm@synopsys.com>
References: <20230514054917.21318-1-quic_kriskura@quicinc.com>
 <20230514054917.21318-4-quic_kriskura@quicinc.com>
 <ZGNy6FvVrBjYmorz@hovoldconsulting.com>
 <b2954b92-8b12-700a-af50-b914af7b0ace@quicinc.com>
 <cacc5813-404a-c2ef-e768-20f2acd696d9@quicinc.com>
In-Reply-To: <cacc5813-404a-c2ef-e768-20f2acd696d9@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SJ0PR12MB5440:EE_
x-ms-office365-filtering-correlation-id: b1243165-5e2c-441c-2db8-08db5685cb3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4oxM/3aCxiX1JpTCqhYQFJlMf5TmfNLQ2qgn0S6ldshipcJD9be4uhYdwYI6yQ/dRw33kLLNGlW0MQsXkw8lGNvT8tMbGoaovzCtwbpGZEUMUHBn7vJy2/YKroMEJ18ODQjD/t3LGzEdwKeq90ACGI5psTzHjJfVZ6IsKXZV99sh70Het1k8Wq9izkw3t1Q4ta6mY1UJqvIG6SbNgrukbEdfNMFa80pqIKoYkcy79VqkLQxd6QMfB+T9h9ZBs4WyePU1E8qbN6gt1ZigJHkBUW+TNXuEdeyBKxQKYy2KjC/S6yveepuZUDQu8wxzZmvQ0SviMx5frMQ/unoeEa/iqhvj/ntZwcEsfgYP7XQIVLW9fpetI5Gg8wbSLE67pglUb09ltJCBOPGVdk+zP/T8fryjd6o+FWG07wOV4NFSOfU1aBJ43pQHEGaTVNGrIdDN4el4//X3r1t/RXHoFls73UTPxRU/oTSXdm+J3QvN4B5BTATndyUTr6aqNp+qmAR1WoiqGRT746D7l4Ofy1MkyUqeK9fS+lUnx60aOH1fqBzbXOrCeUBu4lrADIfcg4A6vC3wuAlRGic2Bpk3KlqKdzxDQQHHgqFnOvo3WnZW+d4uXrEkpAC8EdjCjm7QMeFk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(396003)(366004)(136003)(451199021)(64756008)(53546011)(66946007)(76116006)(66556008)(66476007)(66446008)(54906003)(6916009)(4326008)(316002)(6486002)(478600001)(41300700001)(71200400001)(5660300002)(26005)(186003)(1076003)(7416002)(8676002)(8936002)(6512007)(6506007)(2616005)(83380400001)(36756003)(2906002)(38100700002)(38070700005)(122000001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUR0TGRwNklJZFhNNDgvQVh3YXl4SUdsQ3plTG53Vktab3UyZUJ4bGhjK0Zs?=
 =?utf-8?B?MVdNVmVlYUNLbXJpYWdwbS9EckhEQitBc2txNWM2OE9NWTJJV1Qra0ZuRHVr?=
 =?utf-8?B?d1dRRnFUT2pDa0N0SVZwSExvTExsN1A3enQvQ3FxUmVmbFBUaTJ6Z1J2WGgz?=
 =?utf-8?B?VzNVZ0FxekQ3TEtjT0p5L0M2S2VvVDhDekJzbUlvY0NGbmFLRHNQelZoSHpF?=
 =?utf-8?B?NmVuakd5RlQ4NWxJenFoRGF0Q1ZaSStDRXo0T3BucDBhMTNCNmxLa1RWanI1?=
 =?utf-8?B?UHpBOG9PRW1KWFAwYTlZWTZqemE0QmVsZEhwVldRUUN3Ly9OTFZ4QVE3Yzdh?=
 =?utf-8?B?L01CY0pHMnFQV3UxQUhxYlBhRGd2M1BCcStMTlRXVmZ6QmpBVEFSUm9nK2pL?=
 =?utf-8?B?UVFaWXo3cGVITmlrdzFzeXdOYmlUaWlOWjlhMnNuVi9hVnlBNjF0SnkrUy8x?=
 =?utf-8?B?K2N5VHF5aVdBbFZ6NW56YlNzYkh5YTFMbCtSWk4vbzZmcWxWWFJjdmdHZnpN?=
 =?utf-8?B?U3hQcWZFdTBZTkVhc245TTUvaUhLUk91ZHk3cjdZMm1hUFdkV1o5dUlFdUFH?=
 =?utf-8?B?RmF6dXZlSXJBSnRkR1dZU0dWckNOc0VVZ25xbFo3ZUlxZW9kcy9ybEVuWXdo?=
 =?utf-8?B?MnVWcEt4TUxrV3Qwa0ZFOWYwTjlNaHNHc2d6SEhLRlRXdHBxa1E5SUFVaVlC?=
 =?utf-8?B?VXRUb0NQcnJSU0VMQ09vcU5ncDdrdE94L2pJWXY5WnNpSDkrOW54Y25vYzE5?=
 =?utf-8?B?VTlod1UyZ1VLUmFUZmc2VmNYQVpURWhJamwyZzAvK1JiY0E2RWp0MnBXL05t?=
 =?utf-8?B?MXNFZDFqT01VSytVWDNsckxXWDdCTHo5a2lCTHpNMFZTbUZHZVQwd0Rpc2VJ?=
 =?utf-8?B?bHMvaEMvczJMNTh0L2VuRGRJVzJ3RktnbS9YZm15djE0NkpOK3BXaEgvaWlv?=
 =?utf-8?B?OVRUcEhMdFdFbE02ek5hOXJJSndpVU5zeHdOajJvNmNEcDVmRVlHaG9BZlNL?=
 =?utf-8?B?TmZrYlpDRU8xTnhVRjFTWmNQWHBxcHAwaHN1N2ZTejBpMzZzUEthL1pscGJ3?=
 =?utf-8?B?V0NqcE5OaHZiOTlHN0RZb0JvQzdkTVdtL3BQVW9BTWlMRGVISVo2bEQwWnVD?=
 =?utf-8?B?S25JbE9nNDBidjNycXhZSDdQY0MrZHBtbW1RQU52Wk8zMHlPRS9xVUlCcSsy?=
 =?utf-8?B?UGp1UmZRTXpuUGtLL0pEd2hZQStKcjh0K1Yyb2RhdkE0eWZ0YlgrMnFqcjk4?=
 =?utf-8?B?MkpaS0NOcmplNGFLSWNaMlp3bzBNazNMV0FZaU54VWpKRm9LWUphcHNUTExi?=
 =?utf-8?B?aFV0eVpGY1dSWi9zbjBYdFI4eUozcUFWQTUxUGh0YnVBMi9ySEs4K2huN1lj?=
 =?utf-8?B?QXpVTUxHckpETWpPZUEweFkvRUh2L1RHMmRTNEdnRHZtb3JkOHhvbTl1Q0JF?=
 =?utf-8?B?eFZRd3hlLzVwdkUzNGF1SHY3Z0VlZkNXc3RLd2U2NEdDT0NKdjFiaWhOUVNm?=
 =?utf-8?B?QTJpenZ4eFM1TEpxU2ttWERnZkIvZVEyWmFBMUxXb3dsZGJYbkVoZXkzaUdo?=
 =?utf-8?B?TDY5bytPRGYwUFJ0Sy9TaXgyRTNFdGdzWUs3V2lOVGFwNjF3RnBUZ1c2S1Bt?=
 =?utf-8?B?bnJEOGdMc2lYTjJCeHRLNWluMjM5MzV4NW5LUVhqWWZmeUdiQTlpWG40YTd2?=
 =?utf-8?B?azJYRE8xeTZHNlU4dG5MWTlwdDRhSTB0aEIzWmIvWGxZMEhpNlliVm5qNzly?=
 =?utf-8?B?NnFiVDZjUCtySXViSFZPdm14elVzMlExRlEvOHEveGJKS0Eya0Jib24vaUNy?=
 =?utf-8?B?bDQvdW9uUGlBdzNCSktOM0RoT3ZXVlByK2t2bElEaVpyMnVEZ2tNNEJSankx?=
 =?utf-8?B?UWxVS1BXVDlUa29QUm1QbmtrRHlWbzJwenUyaVp1OCt4MUI3bFNFLzNERnkx?=
 =?utf-8?B?UVpzemVqUE4wcGpzNk1USjlidjJVR1Z6c0dNMEtUeng0TDRRMVBBT1dMZ2p6?=
 =?utf-8?B?ZzNVZ3h1VG9idnRkZVZCREhZTG54OTBWRy9leFY5R21FTWNHWjdwSGRpU1dK?=
 =?utf-8?B?Q1hGOUFqTFYrQzNPUXJHU1Y2OHpDRU5qdXZSV1dtYnNYaHJubHBwamxTa0hl?=
 =?utf-8?Q?nr3PXl5G834tGKxrzANPpSZ6c?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DF81638103D2745801E41523FBE1D2C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?QjU0V2RDTkF4TDJOaWdzVk9SVnVRNm9jVjYyWkNYTHZzTGxwUTFyS2JtUFU1?=
 =?utf-8?B?bXMyckZNNy9GVU44dzB4TWVzeElIMWRaUTZRSWlWSHRpRmRYcWlISXpKb05T?=
 =?utf-8?B?TDBLbEN2b3VDdXZjQ3pNUnRqUUp0emJZOXpZOEFuelBwb0xmRnVZZHpGKzJH?=
 =?utf-8?B?WnF0empoZVYySzlxVlNrRXluYXVyYWpNTk5LOTVCMnIzcS9vMnVmZWZZNkpV?=
 =?utf-8?B?MmIwcEJ1TmpnWndqRjNhd3FyMkxVY0lqZWU4dGpha1lncmRyYi9NOENWdWtj?=
 =?utf-8?B?K1d6MlN4cjlsYlFSNmF5RGx2Q2N6aXh5akhFbWhVRHdRVmVjRGlCQnRlMllz?=
 =?utf-8?B?bHUvakZ6TFprNFNxRkJrQnNxUm5rZ1ZkTWROTVVYQ293RkRaKzFReFlOOTJP?=
 =?utf-8?B?MG9Fd3FabnFnWHJ6RTVYOGNWS2RRZmZQNWY0YXBoYUJQVk1sVEpkMkhIOVBJ?=
 =?utf-8?B?Y1A5ZFhzL0xHOGQxR01TMWZSQ1JsZUhyeWdabVdmeDIvRlFlVTRldGsrdFp2?=
 =?utf-8?B?TjF0RGpYa2toWlFuRkNlUU1QZFo3RE5PQm9YeEQ1WkphQlc0K1pmcEsraGJ3?=
 =?utf-8?B?YmozTSt4Z3RudzhZeVRFOHdIVThmQXp3TDlLWi96eDBNWG55dk1UOFl4VDhh?=
 =?utf-8?B?Ky93VkFTbEdDSUR2TUpBemVNeEs5bklzWlNUeWdlVkc1TnVGMSt2czN1a3R6?=
 =?utf-8?B?VnZOL01aelV2S293eUZKSE1taWxDdkpwL1F6UXhyekpXc3hpM29VWHBvSktE?=
 =?utf-8?B?UGViWnhyVkJyNUNrK3loR05CZWoxcUpTU1pxZXJobjVGeFh3T3ZTcG1NZ05G?=
 =?utf-8?B?RFgrcmw2ZmtieEVPcm0xWm9mcXBjL2p3ajRKN043TEc5ZnNsa0pKT0ZVZGNJ?=
 =?utf-8?B?ZnZsVXhQMUZLNWhBRll6Z2JnRDRodEtVNFR1RzNRWDlmMFRudlhPYkN2MURH?=
 =?utf-8?B?WFdQdG9UWk5IZWh5cnZEZnRJQzFnRXk0Q0JzbUVEdjdzeTQwSEdTbEtyM2tW?=
 =?utf-8?B?aENEMm8wczUxQW8rOTRBTVNzWHFrcXRFMnVNY3FOeHVzSExoL0pZMWdySUV4?=
 =?utf-8?B?NVYvY3E5UXJKMkVGMnZENmJyOWJXZVRPQ0VxQ2svUmZxV3I3b2U0dlNVY1dN?=
 =?utf-8?B?NkVHYVZ4QzhxLzBpQVFQZ2xNWWFtTHQvMmpobG9MTld3aWtOQXNNSndmOUtQ?=
 =?utf-8?B?Q2YvUlFrRC9kQmRGRzhPQk9Tb1ZJNnBWRXk2R1FncmhYUi8zd2lIWTN0SFZl?=
 =?utf-8?B?Z2drNlIxMk9DMVNxY2R5VVZQVFpXNW5ia2FqV0t2RHdXdHZyMlhPUncxa3Zy?=
 =?utf-8?B?S2RtT0l2Q2twamN2S2dtZXNLdDlRekhUS2JKSU1ETnJ6cWtoQTdDMWhJbzY2?=
 =?utf-8?B?bXpuekozdFc0T3c9PQ==?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1243165-5e2c-441c-2db8-08db5685cb3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 03:21:24.3041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nSNVHsY4DVHC4DyGxddjz3PzpHHEVS6+0Oz1QR99/6Y0NUaEwvXYw66cIfeiiaDJXyebbO6E1J8eF1FuFvNwUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5440
X-Proofpoint-GUID: bvXuwmAvCX0vG7uxovXCckaPe47Sglre
X-Proofpoint-ORIG-GUID: bvXuwmAvCX0vG7uxovXCckaPe47Sglre
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_14,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305170027
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBNYXkgMTcsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgUFNTTlYgd3JvdGU6DQo+IA0K
PiANCj4gT24gNS8xNi8yMDIzIDg6MzIgUE0sIEtyaXNobmEgS3VyYXBhdGkgUFNTTlYgd3JvdGU6
DQo+ID4gDQo+ID4gDQo+ID4gT24gNS8xNi8yMDIzIDU6NDEgUE0sIEpvaGFuIEhvdm9sZCB3cm90
ZToNCj4gPiA+IE9uIFN1biwgTWF5IDE0LCAyMDIzIGF0IDExOjE5OjExQU0gKzA1MzAsIEtyaXNo
bmEgS3VyYXBhdGkgd3JvdGU6DQo+ID4gPiA+IEN1cnJlbnRseSBob3N0LW9ubHkgY2FwYWJsZSBE
V0MzIGNvbnRyb2xsZXJzIHN1cHBvcnQgTXVsdGlwb3J0Lg0KPiA+ID4gPiBUZW1wb3JhcmlseSBt
YXAgWEhDSSBhZGRyZXNzIHNwYWNlIGZvciBob3N0LW9ubHkgY29udHJvbGxlcnMgYW5kIHBhcnNl
DQo+ID4gPiA+IFhIQ0kgRXh0ZW5kZWQgQ2FwYWJpbGl0aWVzIHJlZ2lzdGVycyB0byByZWFkIG51
bWJlciBvZiB1c2IyIHBvcnRzIGFuZA0KPiA+ID4gPiB1c2IzIHBvcnRzIHByZXNlbnQgb24gbXVs
dGlwb3J0IGNvbnRyb2xsZXIuIEVhY2ggVVNCIFBvcnQgaXMgYXQgbGVhc3QgSFMNCj4gPiA+ID4g
Y2FwYWJsZS4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoZSBwb3J0IGluZm8gZm9yIHVzYjIgYW5kIHVz
YjMgcGh5IGFyZSBpZGVudGlmaWVkIGFzIG51bV91c2IyX3BvcnRzDQo+ID4gPiA+IGFuZCBudW1f
dXNiM19wb3J0cy4gVGhlIGludGVudGlvbiBpcyBhcyBmb2xsb3dzOg0KPiA+ID4gPiANCj4gPiA+
ID4gV2hlcmV2ZXIgd2UgbmVlZCB0byBwZXJmb3JtIHBoeSBvcGVyYXRpb25zIGxpa2U6DQo+ID4g
PiA+IA0KPiA+ID4gPiBMT09QX09WRVJfTlVNQkVSX09GX0FWQUlMQUJMRV9QT1JUUygpDQo+ID4g
PiA+IHsNCj4gPiA+ID4gwqDCoMKgwqBwaHlfc2V0X21vZGUoZHdjLT51c2IyX2dlbmVyaWNfcGh5
W2ldLCBQSFlfTU9ERV9VU0JfSE9TVCk7DQo+ID4gPiA+IMKgwqDCoMKgcGh5X3NldF9tb2RlKGR3
Yy0+dXNiM19nZW5lcmljX3BoeVtpXSwgUEhZX01PREVfVVNCX0hPU1QpOw0KPiA+ID4gPiB9DQo+
ID4gPiA+IA0KPiA+ID4gPiBJZiBudW1iZXIgb2YgdXNiMiBwb3J0cyBpcyAzLCBsb29wIGNhbiBn
byBmcm9tIGluZGV4IDAtMiBmb3INCj4gPiA+ID4gdXNiMl9nZW5lcmljX3BoeS4gSWYgbnVtYmVy
IG9mIHVzYjMtcG9ydHMgaXMgMiwgd2UgZG9uJ3Qga25vdyBmb3Igc3VyZSwNCj4gPiA+ID4gaWYg
dGhlIGZpcnN0IDIgcG9ydHMgYXJlIFNTIGNhcGFibGUgb3Igc29tZSBvdGhlciBwb3J0cyBsaWtl
ICgyIGFuZCAzKQ0KPiA+ID4gPiBhcmUgU1MgY2FwYWJsZS4gU28gaW5zdGVhZCwgbnVtX3VzYjJf
cG9ydHMgaXMgdXNlZCB0byBsb29wIGFyb3VuZCBhbGwNCj4gPiA+ID4gcGh5J3MgKGJvdGggaHMg
YW5kIHNzKSBmb3IgcGVyZm9ybWluZyBwaHkgb3BlcmF0aW9ucy4gSWYgYW55DQo+ID4gPiA+IHVz
YjNfZ2VuZXJpY19waHkgdHVybnMgb3V0IHRvIGJlIE5VTEwsIHBoeSBvcGVyYXRpb24ganVzdCBi
YWlscyBvdXQuDQo+ID4gPiA+IA0KPiA+ID4gPiBudW1fdXNiM19wb3J0cyBpcyB1c2VkIHRvIG1v
ZGlmeSBHVVNCM1BJUEVDVEwgcmVnaXN0ZXJzIHdoaWxlIHNldHRpbmcgdXANCj4gPiA+ID4gcGh5
J3MgYXMgd2UgbmVlZCB0byBrbm93IGhvdyBtYW55IFNTIGNhcGFibGUgcG9ydHMgYXJlIHRoZXJl
IGZvciB0aGlzLg0KPiA+ID4gPiANCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogS3Jpc2huYSBLdXJh
cGF0aSA8cXVpY19rcmlza3VyYUBxdWljaW5jLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+IMKg
IGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jIHwgMTEzICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysNCj4gPiA+ID4gwqAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmggfMKgIDE3
ICsrKysrLQ0KPiA+ID4gPiDCoCAyIGZpbGVzIGNoYW5nZWQsIDEyOSBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+ID4gPiA+IA0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2Iv
ZHdjMy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+ID4gPiBpbmRleCAwYmVh
YWI5MzJlN2QuLmU5ODNhZWYxZmI5MyAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy91c2Iv
ZHdjMy9jb3JlLmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gPiA+
ID4gQEAgLTE3NjcsNiArMTc2NywxMDQgQEAgc3RhdGljIGludCBkd2MzX2dldF9jbG9ja3Moc3Ry
dWN0IGR3YzMgKmR3YykNCj4gPiA+ID4gwqDCoMKgwqDCoCByZXR1cm4gMDsNCj4gPiA+ID4gwqAg
fQ0KPiA+ID4gPiArLyoqDQo+ID4gPiA+ICsgKiBkd2MzX3hoY2lfZmluZF9uZXh0X2V4dF9jYXAg
LSBGaW5kIHRoZSBvZmZzZXQgb2YgdGhlDQo+ID4gPiA+IGV4dGVuZGVkIGNhcGFiaWxpdGllcw0K
PiA+ID4gPiArICrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB3aXRoIGNh
cGFiaWxpdHkgSUQgaWQuDQo+ID4gPiA+ICsgKg0KPiA+ID4gPiArICogQGJhc2U6wqDCoMKgIFBD
SSBNTUlPIHJlZ2lzdGVycyBiYXNlIGFkZHJlc3MuDQo+ID4gPiA+ICsgKiBAc3RhcnQ6wqDCoMKg
IGFkZHJlc3MgYXQgd2hpY2ggdG8gc3RhcnQgbG9va2luZywgKDAgb3INCj4gPiA+ID4gSENDX1BB
UkFNUyB0byBzdGFydCBhdA0KPiA+ID4gPiArICrCoMKgwqDCoMKgwqDCoCBiZWdpbm5pbmcgb2Yg
bGlzdCkNCj4gPiA+ID4gKyAqIEBpZDrCoMKgwqDCoMKgwqDCoCBFeHRlbmRlZCBjYXBhYmlsaXR5
IElEIHRvIHNlYXJjaCBmb3IsIG9yIDAgZm9yIHRoZSBuZXh0DQo+ID4gPiA+ICsgKsKgwqDCoMKg
wqDCoMKgIGNhcGFiaWxpdHkNCj4gPiA+ID4gKyAqDQo+ID4gPiA+ICsgKiBSZXR1cm5zIHRoZSBv
ZmZzZXQgb2YgdGhlIG5leHQgbWF0Y2hpbmcgZXh0ZW5kZWQgY2FwYWJpbGl0eQ0KPiA+ID4gPiBz
dHJ1Y3R1cmUuDQo+ID4gPiA+ICsgKiBTb21lIGNhcGFiaWxpdGllcyBjYW4gb2NjdXIgc2V2ZXJh
bCB0aW1lcywgZS5nLiwgdGhlDQo+ID4gPiA+IFhIQ0lfRVhUX0NBUFNfUFJPVE9DT0wsDQo+ID4g
PiA+ICsgKiBhbmQgdGhpcyBwcm92aWRlcyBhIHdheSB0byBmaW5kIHRoZW0gYWxsLg0KPiA+ID4g
PiArICovDQo+ID4gPiA+ICtzdGF0aWMgaW50IGR3YzNfeGhjaV9maW5kX25leHRfZXh0X2NhcCh2
b2lkIF9faW9tZW0gKmJhc2UsIHUzMg0KPiA+ID4gPiBzdGFydCwgaW50IGlkKQ0KPiA+ID4gPiAr
ew0KPiA+ID4gPiArwqDCoMKgIHUzMiB2YWw7DQo+ID4gPiA+ICvCoMKgwqAgdTMyIG5leHQ7DQo+
ID4gPiA+ICvCoMKgwqAgdTMyIG9mZnNldDsNCj4gPiA+ID4gKw0KPiA+ID4gPiArwqDCoMKgIG9m
ZnNldCA9IHN0YXJ0Ow0KPiA+ID4gPiArwqDCoMKgIGlmICghc3RhcnQgfHwgc3RhcnQgPT0gWEhD
SV9IQ0NfUEFSQU1TX09GRlNFVCkgew0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqAgdmFsID0gcmVh
ZGwoYmFzZSArIFhIQ0lfSENDX1BBUkFNU19PRkZTRVQpOw0KPiA+ID4gPiArwqDCoMKgwqDCoMKg
wqAgaWYgKHZhbCA9PSB+MCkNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJu
IDA7DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoCBvZmZzZXQgPSBYSENJX0hDQ19FWFRfQ0FQUyh2
YWwpIDw8IDI7DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoCBpZiAoIW9mZnNldCkNCj4gPiA+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7DQo+ID4gPiA+ICvCoMKgwqAgfQ0KPiA+
ID4gPiArwqDCoMKgIGRvIHsNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgIHZhbCA9IHJlYWRsKGJh
c2UgKyBvZmZzZXQpOw0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqAgaWYgKHZhbCA9PSB+MCkNCj4g
PiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7DQo+ID4gPiA+ICvCoMKgwqDC
oMKgwqDCoCBpZiAob2Zmc2V0ICE9IHN0YXJ0ICYmIChpZCA9PSAwIHx8DQo+ID4gPiA+IFhIQ0lf
RVhUX0NBUFNfSUQodmFsKSA9PSBpZCkpDQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHJldHVybiBvZmZzZXQ7DQo+ID4gPiA+ICsNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgIG5leHQg
PSBYSENJX0VYVF9DQVBTX05FWFQodmFsKTsNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgIG9mZnNl
dCArPSBuZXh0IDw8IDI7DQo+ID4gPiA+ICvCoMKgwqAgfSB3aGlsZSAobmV4dCk7DQo+ID4gPiA+
ICsNCj4gPiA+ID4gK8KgwqDCoCByZXR1cm4gMDsNCj4gPiA+ID4gK30NCj4gPiA+IA0KPiA+ID4g
WW91IHNob3VsZCBub3QgbWFrZSBhbm90aGVyIGNvcHkgb2YgeGhjaV9maW5kX25leHRfZXh0X2Nh
cCgpLCBidXQgcmF0aGVyDQo+ID4gPiB1c2UgaXQgZGlyZWN0bHkuDQo+ID4gPiANCj4gPiA+IFdl
IGFscmVhZHkgaGF2ZSBkcml2ZXJzIG91dHNpZGUgb2YgdXNiL2hvc3QgdXNpbmcgdGhpcyBmdW5j
dGlvbiBzbyBpdA0KPiA+ID4gc2hvdWxkIGJlIGZpbmUgdG8gZG8gdGhlIHNhbWUgZm9yIG5vdzoN
Cj4gPiA+IA0KPiA+ID4gwqDCoMKgwqAjaW5jbHVkZSAiLi4vaG9zdC94aGNpLWV4dC1jYXBzLmgi
DQo+ID4gPiANCj4gPiBIaSBKb2hhbiwNCj4gPiANCj4gPiAgwqAgVGhpcyB3YXMgdGhlIGFwcHJv
YWNoIHdoaWNoIHdlIGZvbGxvd2VkIHdoZW4gd2UgZmlyc3QgaW50cm9kdWNlZCB0aGUNCj4gPiBw
YXRjaCBbMV0uIEJ1dCBUaGluaCBzdWdnZXN0ZWQgdG8gZHVwbGljYXRlIGNvZGUgc28gdGhhdCB3
ZSBjYW4gYXZvaWQNCj4gPiBhbnkgZGVwZW5kZW5jeSBvbiB4aGNpICh3aGljaCBzZWVtcyB0byBi
ZSByaWdodCkuIFNvIHNpbmNlIGl0cyBqdXN0IG9uZQ0KPiA+IGZ1bmN0aW9uLCBJIGR1cGxpY2F0
ZWQgaXQgaGVyZS4NCj4gPiANCj4gSGkgVGhpbmgsDQo+IA0KPiAgIFdvdWxkIGxpa2UgdG8ga25v
dyB5b3VyIG9waW5pb24gaGVyZSBvbiBob3cgdG8gcHJvY2VlZCBmdXJ0aGVyLg0KPiANCj4gUmVn
YXJkcywNCj4gS3Jpc2huYSwNCg0KUGxlYXNlIGtlZXAgdGhlbSBzZXBhcmF0ZWQuIFRoZSB4aGNp
LWV4dC1jYXBzLmggaXMgZm9yIHhoY2kgZHJpdmVyIG9ubHkuDQpJdCdzIG5vdCBtZWFudCB0byBi
ZSBleHBvc2VkIHRvIG90aGVyIGRyaXZlcnMuIFNhbWUgd2l0aCBvdGhlciAqLmggZmlsZXMNCnVu
ZGVyIGRyaXZlcnMvdXNiL2hvc3QuDQoNClRoYW5rcywNClRoaW5o
