Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59948700FE4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 22:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239577AbjELUoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 16:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjELUoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 16:44:14 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259F51733;
        Fri, 12 May 2023 13:44:09 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CErm8X019528;
        Fri, 12 May 2023 13:44:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=pk014qT4QAIYDJnkW6AITmQErmoP/QquqAyTc0tcfdE=;
 b=T+oDT7qeqRVJqbN071Wni5IxtuKFYcGdFrNwN69fMvLE/kIBtG2FM6Shc1sH3D+lvjaw
 cZR9OTNsNxqddFGRfTUvsYl0x7WUHpqntuZU0WAv3bG6YCxjj6QG3SYfgcgNQNffD+8p
 GwBlpdptz4jS4aGpbdO0FXMK/9Y7iGlGRGFfeNFULzKCUsYWUMlHjh0bGYDs21Ru+EL5
 JoGwJQNR4kJVAtlci+6V2n+hvjTg6kJJ8C/9hR0IJlTwQkQ6PwN8P5hR8op92laHJZhP
 3EjSpXM4HIRa96vJJmKsyUiq3wTKyVzYrlegtp1aEVlDtwz6jelZCOmhQXk2U2nuebcU HQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3qf770q4n2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 13:44:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1683924245; bh=pk014qT4QAIYDJnkW6AITmQErmoP/QquqAyTc0tcfdE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=X0E5dCS/ZFykKLDThZ3lqRls2/cc4JgBJZm4rjtfxVZ9BMRHvaJqAyQwfVlVcg7rW
         HCW/rjgoSd9zMbAd+rzn8YLaEoWTJuHyiHmJ6SX2EnmCOEOCAwBuSil+kB8pAAinec
         jgREkUdTM8bvI8ETXKoi0AvecjzVmIYDzHo4RQt0FaXkGmLphnpyLIS3ZPCCZEr+U0
         WoSs0AUqpp77EN9M74g1R15ONvsLnXEgNrPsUKbnqYvEeRLlD/fTzw6YIC97VN6ZZR
         a1gCQY4knRxr9At9WHKqwy+3UhQrS5CFTv1/kO1kPbs9OJlDLQKRli87KbKlu11Czj
         MDGPoM6VZp/qw==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6B7F540638;
        Fri, 12 May 2023 20:44:05 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 27692A0073;
        Fri, 12 May 2023 20:44:04 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=ryLjHkgt;
        dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 35BE04063B;
        Fri, 12 May 2023 20:44:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hx96UtSUkw3tQ+f7Xg594SRLw/F9qfo364VxvYO/ediw778t6JZe26fJQtNSpvr55++aU9Z9Aif8Wkt2pvUDzVbRtQ7sw//H06Eg6xvfkR5Ub2Vr1LnWOFloVzPFKFdh7CP5auuQVkoOI3e8lsXiG1mwIr3rYxesqBvXMPaH5EQr/bB6QRwgeGIC+gYQFg1PvYM8h5KJQA9gfUnX87AJZveaSieqnhs2l7WSddAOMG+ale44kNFq0kjePfBxixyZ7U7SKgMF/Hl3Qo2yw5Y4XUnTzBp5s7+MoxoLXTOhJenO6Zv9BToxUWBxyQTmNIRpyha98jUuzuOP2tWR1CsPYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pk014qT4QAIYDJnkW6AITmQErmoP/QquqAyTc0tcfdE=;
 b=k1vZuCSmD+TVKX4rEpCKntx2OXH3F+IoGDzmbDZOY7Ex/hKmMbClMbeBtwZvx92C+giAkNiLoKL7hvXKYK9IiLtZBEyYmwXotwzJFzQQ8wz9xYybt6AIyMp6I0O3l9QC7ErB8SwBBh2vgOwRHbETddjWJRYQoljUI+3pWp3bvJO54AYhI/Vv96D77z9Gs+8Xpl1Vqgl7/bncaIhz/NDljiLK6op+U1Z7Emfn+yaRShZ6D6LhN+F/NRhU4aibmnMZoqm/uOIjaehtOosxcTw+ABY5CRyS2768UDOrY6A1FC/AgPKspg57MK3fs2RcphgD8RQu03j4Z9/6CdCXNqGZZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pk014qT4QAIYDJnkW6AITmQErmoP/QquqAyTc0tcfdE=;
 b=ryLjHkgt+rFIbF1l/qYLFDwwrfycCD9kyS4H3bX6ca8dTwX+i4wJwWnwou+QmQB/Gt2hdFZgK4Icsve8PqLo9cPTfaXvhKyP4fsrEbf8WRwXsDr9OaXCNPjUpEueF9MV769qlgXz2u1Y9cJEHKrni+w9mlMuYU+muWrJYdEqeh4=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DS7PR12MB5887.namprd12.prod.outlook.com (2603:10b6:8:7a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.20; Fri, 12 May 2023 20:43:59 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3400:81ff:f191:b312]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3400:81ff:f191:b312%5]) with mapi id 15.20.6387.019; Fri, 12 May 2023
 20:43:59 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [RFC] usb: dwc3: core: set force_gen1 bit in USB31 devices if max
 speed is SS
Thread-Topic: [RFC] usb: dwc3: core: set force_gen1 bit in USB31 devices if
 max speed is SS
Thread-Index: AQHZhPNlNPBGFOTT10qNz/75xZwuva9W+joAgAAIG4CAAAJTAIAAFleA
Date:   Fri, 12 May 2023 20:43:59 +0000
Message-ID: <20230512204347.ef3yr7vjgrci5fkv@synopsys.com>
References: <20230512170107.18821-1-quic_kriskura@quicinc.com>
 <20230512184630.2kt4xgneiovb3vac@synopsys.com>
 <989832ad-e9b4-7c59-f157-6a9239c1b5eb@quicinc.com>
 <9bd626de-fecb-c789-4b18-a2bf6e4eb427@quicinc.com>
In-Reply-To: <9bd626de-fecb-c789-4b18-a2bf6e4eb427@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DS7PR12MB5887:EE_
x-ms-office365-filtering-correlation-id: 80e70e11-1041-43f2-895b-08db53299cf2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IH6cPreIcm3U+W0AiRjDcvWuREspo9c89FKySPxABnXNzdUW4KOgA+eewVPVU7aoiLnwv0zwT5C3Gd1zMZxAEY/K5WMc1vKN0OgJqaBYQSDR8yS/7jof8EmgjnHIJU4eckKZISwUN1eN6OeiBoOATq3+QEt5RAqmObNI9mRknj/90Jb0SoCrDpE8UyYz8x1vay8i6yOCf5fkGk+p14EXCzDbaEbcewXZdW7r1FSDanYFKt2y26Yr/76V/uegXJs6tbb1oA4WF281m37B+UKHyzU7uD4Gc2/OSu0BA8Of6sVPpnGyp8FSQdoKKI7yi/W/Vxp0JqMGZIYu5o0IDgUEj/qLT280edla/riwpOspUp01YtP3ltSPvHRn2uMWH0l5acQ/oRFpmnOiZXqn96Pf5TR30c/CPUOkipRkFpFfMI6h3fmpAL0K7Q7ySkINNO4zCJbzd6G/RMiPj9UBpmJY5a+coOr/I+0xdVnJzsShRqfN1HAd99kxSoTxwOetSn/Z95O/D928o2NbfMV/pggOibmfEQhDYa5ICe+XxHcRjjh68x5HpH4f67jCv6dl50hz8ise412ePK/iUC5/kj/W3qf/kdq3vaY9bpN5Pqbyi0Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(366004)(396003)(136003)(376002)(451199021)(86362001)(122000001)(38100700002)(38070700005)(36756003)(8936002)(8676002)(966005)(5660300002)(26005)(478600001)(6506007)(6512007)(1076003)(186003)(83380400001)(66946007)(6486002)(6916009)(2906002)(2616005)(71200400001)(54906003)(64756008)(66476007)(53546011)(41300700001)(66446008)(66556008)(4326008)(316002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHgrN3RReStRMWhNK0VrTG5zSFVzUHpkc3VxMEd1Tmx5M3plZmtuR1p3dEQ0?=
 =?utf-8?B?ZTFrcFhxQ2R1SFVSR3hZMG02di9UVGZwNCt4MEVpQWwwdjJkTyt2MzBtNmVI?=
 =?utf-8?B?VWN6b1FaVTdqNWFsOGdvSU9DSmtmZjB0VW01SHFKbVFNTmkyVkZSZlcxRElt?=
 =?utf-8?B?WDJVRlAyZ1ZNald3dVpXdFV5ejExcWFFV3NLSXAyeXMvQm5UcHV6NTNzV3RT?=
 =?utf-8?B?QWFaUVJrT0tLNlNKT3VtdW5QMVhSZWRiYlBOcWJ0ak91R1d1TndCVjJhQUho?=
 =?utf-8?B?cHJYR2VZVzB0NmxSNDFlODlZSUIzMWt1Y3NFSDR2NmRWYzlLUzVvblZFb0Zv?=
 =?utf-8?B?czFqeTZUdHpmUTdBSGZWa0lGRlBxZVptbi9GQmJNaGNsWUd4cU5DVjUzV2Jh?=
 =?utf-8?B?bmg4RXJneTRGSG4rT2Y1NFo5V2EwNEtzUm9lL01RbDh0MDl2QkE3L01MSkhq?=
 =?utf-8?B?NU5aR2dlQWJodnJGOWwza284bUJNcHRkNnd0UGt2akY3R0gra0dKOFpjYzRF?=
 =?utf-8?B?WnFKd1g4V1REWjZ5eWRyUVNWWkcyNDEwM0xXa0dKODBxMmkwaXlCZFJtakgz?=
 =?utf-8?B?b2s4cGZVRHpsSklpRHYrN29URG01UEV0ejl2MHg1Skt2SG5LWDk5VFk1L3ZB?=
 =?utf-8?B?OTN1ZzFwVEUxWDEvRkdJZjNUTHpEb3ZFQzZ1QWFxS25zcVcrY1YrWHd4Z29N?=
 =?utf-8?B?TUx2RGhWM3V4UUNYWlNidFJJb0JPSTUrNCtNMHJuVHVmTFZUVHJzWEhuMFdz?=
 =?utf-8?B?Uy9tVU50amJ1RUpYWVJHNTRyRm01enJjYVVDQnZiaHJTdGhzL2s2YzRheEFs?=
 =?utf-8?B?ZGYwemliV2RJMkRoc2Izd3JrRC9FQS8rY3JMQ0VKTk9XdTFTbFcrMWRmQzl1?=
 =?utf-8?B?V0h6Vk92WjZzdERPMXlXSUk0WEtSVGppdlczR2NwekMzZjFJeE5yT0JqNUUz?=
 =?utf-8?B?YmxsZEVaWVNrSDJxY244LzBJZWZMNVVncXpoU3JDd0NPS1BqWjh0RE9qYjJu?=
 =?utf-8?B?NFYyWk1ZNlJsSTlraHIvSk9qNGFUMFNpeVdRdU1nSnNIaUQ4cEVjbVdqNUtS?=
 =?utf-8?B?SWRsVlFwTW1MV1paSkdidDdNRXFYSjRsQVJCdGVXL3NJYjJCajdVT01mbUpw?=
 =?utf-8?B?bUJobXl6RnpncCtUellJREZSZDQ3a2ZMSDY1SXA2VjJmVlJYTWVUOGlNZDh3?=
 =?utf-8?B?cEc3ZldwUmo2SVhybWE0dUY2bWlZNEp6TkJMNFlDRWRNcHFjUVlPTUNMOTVS?=
 =?utf-8?B?VWhCOVBoQy82b0N0OWlicW5tSHUyaDZWYStSU0JaVDlldzBGNTNkS1hzZk8x?=
 =?utf-8?B?bTgweC8xaEhXZ21teE1BVmlzNktIY3Fteml0MExpbmo4ZVlWUFdpSzU3WE5Q?=
 =?utf-8?B?RkxUbG1jdHBQemhJT1kzM0lVRDRQSUxQMHV6aVMzOWIrWTdwUG0xOC8xTjFQ?=
 =?utf-8?B?SGZ5NUtrS0ZnNXNYaHhZNm5ORW1hUEFUVE9QQjBZdVo4SDc0eDRmUFE0WHRk?=
 =?utf-8?B?cDNXVktKMnZiRGlUVzZZaGdBZjRoNGFBaWIrOHBrT1E3UUlBZFNIWEx4elBV?=
 =?utf-8?B?ZnBhU1ZHcSt4RkFpSTZLaWlkMHAzTk0yY3plWlIvSFUySFdzN21OVjBCaW93?=
 =?utf-8?B?ajJnSnZlWld3V0FQM0R4cGN6allDZEV0U2FHUXpNMGhNNjc2TWZuVnJpaFhG?=
 =?utf-8?B?OUk2VFkzTzd4RVFValhTampNZm1xOW40ZnYzWHIweVZhejlDSndLYjZBZGJ2?=
 =?utf-8?B?M1pDTlljNnFQVGlCZFlzTXJOT3JNVnc3a1JQYjJTT2dyK2daU3NBUTFSOVNZ?=
 =?utf-8?B?bS9FQUdRK1pZVWNnY2R2YTBEcjNVdWphOGF2dHBINW1mZjhaOTgvajhUTERD?=
 =?utf-8?B?U0dFRkhNRWxmWkpTVU5FbmtoUGlINExqYUZnZS93YWc1OUlteDNHZCs1RzBQ?=
 =?utf-8?B?Y1VzWGlRblhCN3E5b0pkZEMvQm0yQXpEWkJSTGJxc2pNc043R2tXYzRNSmdT?=
 =?utf-8?B?cHBEOHJvNEtGeUtnY1lETUY5L3JkL2ZwYnltQUZucXVHUFZ1TGp3UDAwSDRB?=
 =?utf-8?B?aHZEU2kyWitSbTNwVnRFV3E2SzM2aWhkalZHRUwzNnRKcHJHbWUzdTZMSVp0?=
 =?utf-8?Q?2EO3QAok91Bpi/c7NiyvH9BA2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38C9DBA026AEC3428D038707D29CA64B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EJqpiXZiKgjUx2gt01oMG94uA7IIKTRuABq+TF4D1ROLbWVjrKaasdsVbwoDhMn3RQr7OJeG4hYJ7F7N5CxMVnKBbwU6rOyxQEOBdQ5LU90HZYe3+fPbIW6vEZuWO0in7sgcsPKFe56Eru3tljfXmAKD1nY4WgrCA4qMCTqeicPHZwQRI8lBeUNVs503FrLWiK0+JC6ufNQ3D/BV0zrhYRSvQ43n0BOOSaD6erEOCF4dZdein6pg1DDrLoUOpBe3dtcpHvv1dEYOk2VmWlovn4OWy0kRoaP41Nh73BTROesYyTNXlJdJmCDQU8+uttxH8CA2PdQaw/sFfaxNEfjihED7YKr2Wv70RU9bsqrcdCaKVUY7pBYX9N5aec+ySX72wFu4wE4d42o7X5Rv7+MqmNTGDhoVd1de19/ttdpqH95x1paiwVKVnbzMp/9BFFQ46kGA+tanNmgmIowyWagfw0wRRLsYNRuYsmmgWmEuNAPoKelXUqOiDNcuWs5rdoGStdubPGqzBsyg8FKtvJYAsx9lelwldA48EtVaCWignEHxOUS4S45tICOH4caUgjH0PDLF4CFGsqS8sDixh+Z2VG/JNLupL/nmC/Eyyf3GaClmpdmkZjQA7+kqwQ4k1bMBmzbdD0nfhVJbaG2Tx7Wi8KIuMS0AgDPB4AHu1bsLIT1XDbFpFBK7GBM58f8GcHJ/RqMgOjX0arkmrKgzHOrCC3EjjFeoJRdQaSrH1UkS9I55l61B4WSmOKXVRQiKGOMu/cRYMxcX9b1siPHFuI2ImC8IbRHKnEfA7euEX5XCuw7TBmBRxsYj+JqCH3zVghDkDx25+AXmbD91ceZm8Qp8fTuUUtEA4bjNGA9gAYngGjAWMDLDB3ZCYeFdbKZzxTCsGl7dFzP2I8ItR6MZOdJFNQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e70e11-1041-43f2-895b-08db53299cf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2023 20:43:59.4482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B67IfJP508h/xe0gYXlCvLID3/ePzGLnfaZGEh6AyHMN29ZN5/02TSKOAhXlPPDivI9iXDoOsyoLDBm8Kj9c+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5887
X-Proofpoint-GUID: cnUDOKOcek1DSjgO6WMol7LU7WRsG-D4
X-Proofpoint-ORIG-GUID: cnUDOKOcek1DSjgO6WMol7LU7WRsG-D4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_12,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 phishscore=0 suspectscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120174
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCBNYXkgMTMsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgUFNTTlYgd3JvdGU6DQo+IA0K
PiANCj4gT24gNS8xMy8yMDIzIDEyOjQ1IEFNLCBLcmlzaG5hIEt1cmFwYXRpIFBTU05WIHdyb3Rl
Og0KPiA+IEhpIFRoaW5oLA0KPiA+IA0KPiA+IE9uIDUvMTMvMjAyMyAxMjoxNiBBTSwgVGhpbmgg
Tmd1eWVuIHdyb3RlOg0KPiA+ID4gT24gRnJpLCBNYXkgMTIsIDIwMjMsIEtyaXNobmEgS3VyYXBh
dGkgd3JvdGU6DQo+ID4gPiA+IEN1cnJlbnRseSBmb3IgZHdjM191c2IzMSBkZXZpY2VzLCBpZiBt
YXhpbXVtX3NwZWVkIGlzIGxpbWl0ZWQgdG8NCj4gPiA+IA0KPiA+ID4gV2UgdXN1YWxseSBjYWxs
IHRoZSBjb250cm9sbGVyIGR3Y191c2IzLCBkd2NfdXNiMzEsIG9yIGR3Y191c2IzMi4NCj4gPiA+
IA0KPiA+ID4gPiBzdXBlci1zcGVlZCBpbiBEVCwgdGhlbiBkZXZpY2UgbW9kZSBpcyBsaW1pdGVk
IHRvIFNTLCBidXQgaG9zdCBtb2RlDQo+ID4gPiA+IHN0aWxsIHdvcmtzIGluIFNTUC4NCj4gPiA+
ID4gDQo+ID4gPiA+IFRoZSBkb2N1bWVudGF0aW9uIGZvciBtYXgtc3BlZWQgcHJvcGVydHkgaXMg
YXMgZm9sbG93czoNCj4gPiA+ID4gDQo+ID4gPiA+ICJUZWxscyBVU0IgY29udHJvbGxlcnMgd2Ug
d2FudCB0byB3b3JrIHVwIHRvIGEgY2VydGFpbiBzcGVlZC4NCj4gPiA+ID4gSW5jYXNlwqAgdGhp
cyBpc24ndCBwYXNzZWQgdmlhIERULCBVU0IgY29udHJvbGxlcnMgc2hvdWxkIGRlZmF1bHQgdG8N
Cj4gPiA+ID4gdGhlaXIgbWF4aW11bSBIVyBjYXBhYmlsaXR5LiINCj4gPiA+ID4gDQo+ID4gPiA+
IEl0IGRvZXNuJ3Qgc3BlY2lmeSB0aGF0IHRoZSBwcm9wZXJ0eSBpcyBvbmx5IGZvciBkZXZpY2Ug
bW9kZS4NCj4gPiA+IA0KPiA+ID4gU2luY2UgdGhpcyBpc24ndCByZWFsbHkgYSBmaXgsIGNhbiB3
ZSByZXBocmFzZSB0aGUgbGluZXMgYmVsb3cNCj4gPiA+IA0KPiA+ID4gPiBGaXggdGhpcyBieSBm
b3JjaW5nIGNvbnRyb2xsZXIgc3VwcG9ydGVkIG1heCBzcGVlZCB0byBHZW4xIGJ5DQo+ID4gPiA+
IHNldHRpbmcgTExVQ1RMLkZvcmNlX0dlbjEgYml0IGlmIGNvbnRyb2xsZXIgaXMgRFdDM19VU0Iz
MSBhbmQNCj4gPiA+ID4gbWF4IHNwZWVkIGlzIG1lbnRpb25lZCBhcyBTUyBpbiBEVC4NCj4gPiA+
IA0KPiA+ID4gQXMgZm9sbG93Og0KPiA+ID4gVGhlcmUgYXJlIGNhc2VzIHdoZXJlIHdlIG5lZWQg
dG8gbGltaXQgdGhlIGhvc3QncyBtYXhpbXVtIHNwZWVkIHRvDQo+ID4gPiBTdXBlclNwZWVkIG9u
bHkuIFVzZSB0aGlzIHByb3BlcnR5IGZvciBob3N0IG1vZGUgdG8gY29udHJhaW4gaG9zdCdzDQo+
ID4gPiBzcGVlZCB0byBTdXBlclNwZWVkLg0KPiA+ID4gDQo+ID4gPiANCj4gPiBTdXJlLCB3aWxs
IHJlcGhyYXNlIGl0IGFjY29yZGluZ2x5LiBUaGFua3MgZm9yIHRoZSBzdWdnZXN0aW9uLg0KPiA+
ID4gPiANCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogS3Jpc2huYSBLdXJhcGF0aSA8cXVpY19rcmlz
a3VyYUBxdWljaW5jLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+IERpc2N1c3Npb24gcmVnYXJk
aW5nIHRoZSBzYW1lIGF0Og0KPiA+ID4gPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL2U0NjVjNjljLTNhOWQtY2JkYi1kNDRlLTk2Yjk5Y2Zh
MWE5MkBxdWljaW5jLmNvbS9fXzshIUE0RjJSOUdfcGchWWlRcGpaSUpBdy15dTZnRXdiS3FiNW51
c2puS1E5ZFFKcnVseDM5bFFQLTdKTWhjTkEyeGQ4dUxKb1pfSEU4U3VHNFJtMnV2aEpUU2RRMmsw
ZkpWQXhVMlJXWUhIZyQNCj4gPiA+ID4gDQo+ID4gPiA+IMKgIGRyaXZlcnMvdXNiL2R3YzMvY29y
ZS5jIHwgMTMgKysrKysrKysrKysrKw0KPiA+ID4gPiDCoCBkcml2ZXJzL3VzYi9kd2MzL2NvcmUu
aCB8wqAgNCArKysrDQo+ID4gPiA+IMKgIDIgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygr
KQ0KPiA+ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5j
IGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gPiA+ID4gaW5kZXggMGJlYWFiOTMyZTdkLi45
ODlkYzc2ZWNiY2EgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5j
DQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ID4gPiA+IEBAIC0xMTYs
NiArMTE2LDE4IEBAIHZvaWQgZHdjM19zZXRfcHJ0Y2FwKHN0cnVjdCBkd2MzICpkd2MsIHUzMiBt
b2RlKQ0KPiA+ID4gPiDCoMKgwqDCoMKgIGR3Yy0+Y3VycmVudF9kcl9yb2xlID0gbW9kZTsNCj4g
PiA+ID4gwqAgfQ0KPiA+ID4gPiArc3RhdGljIHZvaWQgZHdjM19jb25maWd1cmVfaG9zdF9zcGVl
ZChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiA+ID4gPiArew0KPiA+ID4gPiArwqDCoMKgIHUzMiByZWc7
DQo+ID4gPiA+ICsNCj4gPiA+ID4gK8KgwqDCoCBpZiAoRFdDM19JUF9JUyhEV0MzMSkgJiYNCj4g
PiA+ID4gK8KgwqDCoMKgwqDCoCAoZHdjLT5tYXhpbXVtX3NwZWVkID09IFVTQl9TUEVFRF9TVVBF
UikpIHsNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgIHJlZyA9IGR3YzNfcmVhZGwoZHdjLT5yZWdz
LCBEV0MzX0xMVUNUTCk7DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoCByZWcgfD0gRFdDM19MTFVD
VExfRk9SQ0VfR0VOMTsNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgIGR3YzNfd3JpdGVsKGR3Yy0+
cmVncywgRFdDM19MTFVDVEwsIHJlZyk7DQo+ID4gPiA+ICvCoMKgwqAgfQ0KPiA+ID4gPiArfQ0K
PiA+ID4gPiArDQo+ID4gPiA+IMKgIHN0YXRpYyB2b2lkIF9fZHdjM19zZXRfbW9kZShzdHJ1Y3Qg
d29ya19zdHJ1Y3QgKndvcmspDQo+ID4gPiA+IMKgIHsNCj4gPiA+ID4gwqDCoMKgwqDCoCBzdHJ1
Y3QgZHdjMyAqZHdjID0gd29ya190b19kd2Mod29yayk7DQo+ID4gPiA+IEBAIC0xOTQsNiArMjA2
LDcgQEAgc3RhdGljIHZvaWQgX19kd2MzX3NldF9tb2RlKHN0cnVjdA0KPiA+ID4gPiB3b3JrX3N0
cnVjdCAqd29yaykNCj4gPiA+ID4gwqDCoMKgwqDCoCBzd2l0Y2ggKGRlc2lyZWRfZHJfcm9sZSkg
ew0KPiA+ID4gPiDCoMKgwqDCoMKgIGNhc2UgRFdDM19HQ1RMX1BSVENBUF9IT1NUOg0KPiA+ID4g
PiArwqDCoMKgwqDCoMKgwqAgZHdjM19jb25maWd1cmVfaG9zdF9zcGVlZChkd2MpOw0KPiA+ID4g
wqA+IFRoZSBMTFVDVEwgZG9lc24ndCBjaGFuZ2UgdW50aWwgdGhlcmUncyBhIFZjYyByZXNldC4g
TGV0J3MganVzdD4NCj4gPiBpbml0aWFsaXplIGl0IG9uY2UgZHVyaW5nIGR3YzNfY29yZV9pbml0
KCkgaWYgdGhlIEdIV1BBUkFNIGluZGljYXRlcyB0aGUNCj4gPiA+IGNvbnRyb2xsZXIgaXMgRFJE
IG9yIGhvc3Qgb25seS4NCj4gPiA+IA0KPiA+IA0KPiA+IEkgdGhvdWdodCBHQ1RMIENvcmUgc29m
dCByZXNldCBtaWdodCBjbGVhciB0aGlzIGJpdC4gVGhhdCBpcyB3aHkgSQ0KPiA+IHBsYWNlZCBp
dCBoZXJlLiBGb3IgZGV2aWNlIG1vZGUgZ2FkZ2V0LmMgdGFrZXMgY2FyZSBvZiBsaW1pdGluZyBz
cGVlZC4NCj4gPiBTbyB3YW50ZWQgdG8gZG8gdGhpcyBzZXR0aW5nIG9ubHkgZm9yIGhvc3QgbW9k
ZSwgYmVmb3JlIHdlIGludm9rZSBob3N0DQo+ID4gaW5pdC4NCj4gPiANCj4gPiBUaGFua3MgZm9y
IGxldHRpbmcga25vdyB0aGF0IG9ubHkgVkNDIHJlc2V0IGFmZmVjdHMgdGhpcy4gV2lsbCBtb3Zl
IHRoaXMNCj4gPiBjaGVjayB0byBjb3JlIGluaXQuDQo+ID4gDQo+ID4gUmVnYXJkcywNCj4gPiBL
cmlzaG5hLA0KPiA+IA0KPiANCj4gSW4gZmFjdCwgVGhlIGZvbGxvd2luZyBzbmlwcGV0IGZyb20g
cHJvZ3JhbW1pbmcgZ3VpZGUgaXMgd2h5IEkgdGhvdWdodCBHQ1RMDQo+IHJlc2V0IGNhbiBhZmZl
Y3QgdGhpcyByZWdpc3RlcjogKCB0aGUgYmVsb3cgaXMgZnJvbSB1c2IzIHByb2cgZ3VpZGUsIEkN
Cj4gYXNzdW1lIHRoaXMgd291bGQgYmUgYXBwbGljYWJsZSBmb3IgdXNiMzEgYXMgd2VsbCkNCg0K
Tm8uIERvbid0IHVzZSB0aGUgc2FtZSBwcm9ncmFtbWluZyBndWlkZSBmb3IgZGlmZmVyZW50IGNv
bnRyb2xsZXINCnZlcnNpb24uIFRoZSB2ZXJzaW9uIHlvdSdyZSB1c2luZyAoMS45MGEpIGRlcHJl
Y2F0ZWQgR0NUTC5Db3JlU29mdFJlc2V0Lg0KDQo+IA0KPiBGaWVsZHMgZm9yIFJlZ2lzdGVyOiBH
Q1RMDQo+IENvcmUgU29mdCBSZXNldCAoQ29yZVNvZnRSZXNldCkNCj4g4pagIDEnYjAgLSBObyBz
b2Z0IHJlc2V0DQo+IOKWoCAxJ2IxIC0gU29mdCByZXNldCB0byBjb250cm9sbGVyDQo+IA0KPiAg
Q2xlYXJzIHRoZSBpbnRlcnJ1cHRzIGFuZCBhbGwgdGhlIENTUnMgZXhjZXB0IHRoZSBmb2xsb3dp
bmcNCj4gcmVnaXN0ZXJzOg0KPiDilqAgR0NUTA0KPiDilqAgR1VDVEwNCj4g4pagIEdTVFMNCj4g
4pagIEdTTlBTSUQNCj4g4pagIEdHUElPDQo+IOKWoCBHVUlEDQo+IOKWoCBHVVNCMlBIWUNGR24g
cmVnaXN0ZXJzDQo+IOKWoCBHVVNCM1BJUEVDVExuIHJlZ2lzdGVycw0KPiDilqAgRENGRw0KPiDi
lqAgRENUTA0KPiDilqAgREVWVEVODQo+IOKWoCBEU1RTDQo+IA0KPiBJZiBzbywgZG9uJ3Qgd2Ug
bmVlZCB0byBkbyB0aGlzIHNldHRpbmcgYWZ0ZXIgZXZlcnkgR0NUTCBjb3JlIHNvZnQgcmVzZXQg
Pw0KPiANCg0KRG9uJ3QgbG9vayBhdCB0aGF0IGxpc3QuIEl0J3MgaW5jb21wbGV0ZS4gRGVwZW5k
aW5nIG9uIHdoYXQgcHJvZ3JhbW1pbmcNCmd1aWRlIHZlcnNpb24geW91IGhhdmUsIHVzdWFsbHkg
dGhlIG5ld2VyIHZlcnNpb25zIGRvY3VtZW50IHRoZXNlIGluZm8NCnVuZGVyICJBZGRpdGlvbmFs
IFJlZ2lzdGVyIEluZm9ybWF0aW9uIg0KDQpJTUhPLCBpdCdzIGFyZ3VhYmx5IGNsZWFuZXIgdG8g
cGxhY2UgaXQgaW4gZHdjM19jb3JlX2luaXQoKSwgYnV0IGl0J3MNCmZpbmUgdG8gcGxhY2UgaXQg
aW4gaG9zdCBpbml0IGFsc28uIElmIHlvdSBmZWVsIGl0J3MgYmV0dGVyIHRvIHBsYWNlIGl0DQpp
biBob3N0IGluaXQsIGl0J3MgcmVhc29uYWJsZSBhbHNvLg0KDQpUaGFua3MsDQpUaGluaA==
