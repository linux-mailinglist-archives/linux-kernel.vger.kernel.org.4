Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D326DB80C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 03:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjDHBpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 21:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDHBpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 21:45:11 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E86783F6;
        Fri,  7 Apr 2023 18:45:10 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 337IRfJT003563;
        Fri, 7 Apr 2023 18:45:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=NuWg2iSwYNXiJTlWgYwro0e6QmYs40xXKI0NSz+ZCt8=;
 b=s7LXuok1I45pcVqgFDWn9OIgjViUSA30Kxf2ZA0YJhQHGgVj1dPh9ScYVwM19O9sqeWF
 SxoxIiT6zxrLbxbc2snIkIDqjBt0r/Yxu9lVFf2ezL4G9x0FQeeDknbPYgKO5mUzEgb2
 lPvBalX1HQRA8UWQO7oSO4VIWtrkineGPbaY8PL/auBfm+zqVFMFwNdkaq/wbAyHwiWO
 /xxYsqfJ++oh2fil26MwdnIa9g8ZFnhn6zE8Bo7XNoVpUe/YmWc4v5IAyNfk/J19jtQS
 q4fuwEBgGFhb7qmiwENvPJONLHO661/QX6H2i0IgAX1VsRXEfMZiX5BoDe0iMZgteBYc Rw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3ppkhy7uyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 18:45:06 -0700
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id F2764C05B0;
        Sat,  8 Apr 2023 01:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1680918306; bh=NuWg2iSwYNXiJTlWgYwro0e6QmYs40xXKI0NSz+ZCt8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=RA78cRQYOaJZIKqEIWR7iFkFqlRVHEOGj/HRsvrX4VFMWII6YFOhjaFFpF6TgTIWp
         og0s45PovIVvbxJHo0yKjMrVlTi8H4Nhc2eKxp2NAvaPkqWcbuP9dIVErb+OZeXU80
         bD80KD7Zb34c7wXqEP1GSeDQhnN+7rasBeIqf/kEazlsSIYjaAWLbENTL+n8TBbFx3
         gqBRBV0WvvWFBDCjS6SIiHCv0uwWj73YMMznDHoIR0IKi0Wex+34PuyWrhwZuDm6zw
         DRVm9NiR2O0HvuzEecEhrjn+LA2/D2nYnasU1oqw1/WekOKjK/VLczdOW3kgKWM4LT
         tJy6QdvOJnZvQ==
Received: from o365relayqa-in.synopsys.com (sv2-o365relay7.synopsys.com [10.202.1.143])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relayqa-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 5C2CBA005E;
        Sat,  8 Apr 2023 01:45:05 +0000 (UTC)
Authentication-Results: o365relayqa-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relayqa-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relayqa-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=rIE5dVnF;
        dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relayqa-in.synopsys.com (Postfix) with ESMTPS id D5D57220D71;
        Sat,  8 Apr 2023 01:45:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDe+BDgHnTT1CTEisBrD4CXC+UkbAWOpurvBKssZzUebGzAwMzuMrvv7wL7U7kQUqbLF/IrrN2XzGetvKU7s1HZ+tdm9qyBNPJq13PgNqRTY8uaIdZKV93Daq+S/9ijywCpaTMvqqqY8yiUz3jttVmVtAAdwZw05Uqgd0Nirncq8bGHVTQG13J8FAVIVSw7RsOWZtSwN66Ma6b79n/7wfEEnUu4/xdyLjo23fqlV7D/L5Gd4evRtfhtpQXbr555FNrf7RX8KgJqPFs0OakuBSJGR5R4UiD78uXojIrAx2pUUjKkU3AyN3SGDiOTcoL4iAUrOGWmntQz/zlIcM73yYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NuWg2iSwYNXiJTlWgYwro0e6QmYs40xXKI0NSz+ZCt8=;
 b=mRWDSBRL94DrTH6neJDNcOwE45mgilCKUwqrN7gcjLONKn/5St4puUcbuWgPIwHwNoUIolma5NRAggV+T1ywBy+LJP+KnbDTMXsov/ML/D2sqLkpjodAn6DDuxl0Gg0QAoYZEMtyvEqPOMA1bCsQHsAD1930/dga63aO+syBKAnV6itIu/7RhW3JkfYrzct0WQktrytAAYf1LsateLB5CR+9J7/3QrD6dzzG8yA1iB8DBzeNJuHyDU21obRf0cTXVU76vKynY1k1/mIUtiMtRbEGaPOCfrcBRDEXMNvQz+A4a0sjSopK967xpB5Z3wPwKSCmaRzjkTmMBtvdFemBAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NuWg2iSwYNXiJTlWgYwro0e6QmYs40xXKI0NSz+ZCt8=;
 b=rIE5dVnFEMNDqYgIKjDb+B5A0VHl9S6HF8AMkbx+tEoWU/5LThh9uf6khyhd3n58bDtuKFezV0FQyr98/767xg7o5lShBbwvpGSAWdqqjT59tkWVUFo2YFLYeedgWYzx3CRW/At9TSgyPq+po/AqpLXYcUabFOxvWIgk5J/Qor8=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM4PR12MB6663.namprd12.prod.outlook.com (2603:10b6:8:bb::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.33; Sat, 8 Apr 2023 01:45:02 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c22b:eb27:6df3:8d25]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c22b:eb27:6df3:8d25%4]) with mapi id 15.20.6277.034; Sat, 8 Apr 2023
 01:45:02 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_ugoswami@quicinc.com" <quic_ugoswami@quicinc.com>
Subject: Re: [PATCH v2 1/3] usb: dwc3: gadget: Refactor EP0 forced
 stall/restart into a separate API
Thread-Topic: [PATCH v2 1/3] usb: dwc3: gadget: Refactor EP0 forced
 stall/restart into a separate API
Thread-Index: AQHZaaIKTb4ORw9hS0+B5QSifRKE1q8gpC0A
Date:   Sat, 8 Apr 2023 01:45:01 +0000
Message-ID: <20230408014456.nc2dgoavurtonq3r@synopsys.com>
References: <20230407224025.22315-1-quic_wcheng@quicinc.com>
 <20230407224025.22315-2-quic_wcheng@quicinc.com>
In-Reply-To: <20230407224025.22315-2-quic_wcheng@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DM4PR12MB6663:EE_
x-ms-office365-filtering-correlation-id: 0c83e7cb-acdf-4b10-16a5-08db37d2de76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QmdlK01eESSP1MSywjoMGXDHkENeY9epAecCCPC4rHd034k1NAcB+5CWZ5s5TxKJiFhrkFEeSndmn3u4US8HPm6pVcZInIiSqb6aiLECsMj8NHdI9ShHPrCscKyWNU9lJ8nkY8cJ8Lc43X1ELmDXGZT7vwXXKDPY0q2LiXAFtxEs7CCr18nfMk3j61EW016CGtoEK2VrEZhgUyedWRvY2pXa7AJtyOnYP4dXqPNOf/QY6D4U+4YAzyjnwMWfTdCnWmLF+dJdqYS5q2OdNaTRh4VBRz22/QKF7YzjcM/Jbkfq3QwlCJunF98hquxS4gLm0GG2QPRvODxtdWbAtdTR8VNauER/7fLe4Ntz5ZuvfXr7vHqhb2A5ZIcLebySpGZV3OJSzLj2FpHnTD97/o5ULizW74WQhoicAoIowmVObVi0jY4igFspt97hMWQRLvnlqI2wF+DhXYxhY67ZzEQ8mfkKrt1gTXbQOLR/pne15wmbk1UmnmXO3IxaeMguWFlnp7mywBLhauWAY4767jaGjDUc5GbNCCq9mmAQycTKuqq1rqlv1xGQHrJhPzdPBNy+imcTBnPYBZv9CKNSRCpIx78PdyFHD/dcaqgkWQ5N1PWCdGRA0dFIjEKJN2KmxdMW1c+bnwXbyDHvm6MOTdKZaw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(366004)(39860400002)(346002)(396003)(451199021)(71200400001)(2906002)(6512007)(26005)(2616005)(186003)(1076003)(4326008)(66476007)(83380400001)(8676002)(66556008)(6916009)(66946007)(76116006)(66446008)(41300700001)(54906003)(64756008)(478600001)(5660300002)(316002)(6486002)(8936002)(6506007)(38100700002)(122000001)(36756003)(38070700005)(86362001)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXVzYlVyN29HL0FUV25OWUpJWWM5UFozUExuVzk5aGszbWxXYXhhejh4bSsv?=
 =?utf-8?B?cG83NStWcUtzOWJNRURkbWRYVUpkcWpnQS9OejNKSlVMQnhIRVhjMXV3R3BV?=
 =?utf-8?B?alQvc0dlTlVMVWRPZUw2Skl3VEplTFhJaElWa3NkdzFPRi9PM1dyT2pwZzhD?=
 =?utf-8?B?N09OZ3RRdjJ1ME5lcUw5VzV0OWdOWTVSVVVNMzM1Y1FreDZKc3JaejBDVzV3?=
 =?utf-8?B?d0IyTVp6N3JxTlp6NEtLTFExYWJpWEk4Qld0Nkl1Q0psM2k2OGVXSlJFQzR5?=
 =?utf-8?B?V0dqc3kydVBaNjVjWG5wTXZLWlRraXRaWXdralVsYzlsMzI5UGF1NHAwNmR4?=
 =?utf-8?B?Q0diUit5WWdOVTBiWmhHMjdtakdKVEh1bFNMRnF2YnVlak4ycE5zb2gzY1VT?=
 =?utf-8?B?WWxSWC9PMEczTEFnY2FUMWpvc3BTNHE5cmNtSWpRbVRpYStxWkprclNKVU1R?=
 =?utf-8?B?U0xLV3JUeHZuTVMxc3JPYjVxN1VBYXVvMXNoSlNyZkZMREtNMEprNjJvcTFi?=
 =?utf-8?B?RGM1SGlHczd0RERSUTA1M3B3Y0pxVUZIM2h5WDg5QWo5bkl1MUtubUx2bTRS?=
 =?utf-8?B?eForLzI4a2g0Wmh6SHMwU2Z0eGxkNU9jbmJDM1FmVUhablNNMXhiMUt5WnZH?=
 =?utf-8?B?TzFCTysvdzl5REJUY3RwNzFGZTVtRlh3NXZWa3RjOTNoK0FUMlFvMVlRVm9r?=
 =?utf-8?B?MXJZMWFYWktNc00xYkJ6bERUb0xoK0p1Vlh1WlVFZFowOVA0dEdJc0Fnd3dU?=
 =?utf-8?B?WWpYbnRTbGVMYnhlUmtyWndrNUE1YWFocDR3UEFGbUl4OTlyWi9WREVoZFVV?=
 =?utf-8?B?bEpLbTlwZ05mKzR5Q1UwenlkSzByL0Zxdk1tT21VK1dBWUNDZ0hBa3E2N0VU?=
 =?utf-8?B?Z3ZOcmwrOEhIdzFUMUlUN1YrN1hyUUN2ZmpRQmcvcDFWQnJpMXQweWsxYU96?=
 =?utf-8?B?anJDTXNQSGhYUnZqUEpScTJZa2VMdW1SZ2g2aENMTGduajd0M2xIUm9idUFT?=
 =?utf-8?B?Ny9xQW5tSEZJZnc5ajdVb2dLRTFNWVUwVVNaQkRYaUpkRGtCaDZpRXUwU1Br?=
 =?utf-8?B?VVVpTUhCc0NicjdCbjhFTjVUaWxMRUI4cTdhK3h5SDRUYlE4TVBURytvb2ZU?=
 =?utf-8?B?dzRlenpjTHhvQVFVY2VOek5BMjZuMU1mNXkvYlFzOTRVMWdXQWRkeGthQ2tI?=
 =?utf-8?B?ZTlTb2oxQ2JNUjloS1E1eXZ6dWprL3UyRGVrMU9yNkhxRkI5QTVYQ3I3T2Zn?=
 =?utf-8?B?YnFSSWRqRzgrWUo2dFFSYi85RE8rVUhFbG8rUnFvOWdKeDRCTnF0OXFWeC9r?=
 =?utf-8?B?UlNsMjQ3VlVraENNNS9zeVpjT0M4V3MzZkdENTBCRHI1Qm5zakpRTmQ1WWJt?=
 =?utf-8?B?ME1OeUgrZ0JrZUQyV3NUblFUaHpBYXRZNVZzN01iZVF3bE90bDhrU0pvYUNk?=
 =?utf-8?B?MHNkR2pzU3BxWnk1alFsN2NlSkx1bXNvazloT2xHdThvWVZaUVd5T0diMHgz?=
 =?utf-8?B?bzk1dTl1RmQ2ZFJONFNFdkVRbjY4c0xURjZHeEU1YlRWakJqWW1tRFFYOGVI?=
 =?utf-8?B?RzQydW5sTmV2Q2pFWjBiU2NjbDRLbFJIbmlMTnJXdExab1dqWnpIaFNqdXBK?=
 =?utf-8?B?UEp4a1pqTUN5bTdUcHA4Wm1yNGZBaDB3TnVCZElaMUlXWklvTlVUcjNETDE3?=
 =?utf-8?B?eHNxT0hYL0hWaDJqZ3NiVzduOTRLMUMvNy9uSTdKakVGY3g0WnpjTlg4bmxQ?=
 =?utf-8?B?WXZHditKK29lWmplUWhlNFRWRzFsUDh1QXhCdzlEdHVhdTRYUWFlOTRkT2VG?=
 =?utf-8?B?TnpObDg3Z1hqSUgyNkYwWmh2a0RuZU1RYSt0aXVFQ2hsVCtDQmswakV0NSt6?=
 =?utf-8?B?aTNQNEIrR0ptOEpEQk4vNGFGeURwRXluMlBCODJqZVV6aktJVDlvQ3Fvdk92?=
 =?utf-8?B?Q3ZQOEdSOHZ0eno3ZEhuRlNLcU55TU9wYzh5SDZ0dzRqVGlvaWJNTStiUWFN?=
 =?utf-8?B?My9LZkU5ektQSGRnUEJTMmdIVFoxY0xvK0NKaGVZb3RDR2JzSEMrYjFadFls?=
 =?utf-8?B?ZTdvR3lITDQ3WEhkcW03UDlEcTNZN0JmV0FPNkFMNWxqRmxUQlFMd1F0VHBs?=
 =?utf-8?Q?kXkD+laSs0K8n5k4x1MdqgF51?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <37F0359D4085F74B8DCDC142956D49E1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jQKzvRktf+NFjXYJ+nm1FmrISGuLW/sDUV96RmsW++wwJoT+2rbPvjYfcpn2c+LvizcL/HWlazKHmtdmarfVPg+/WorkgsXBDsQWTpS7M38IUpC4FEjJBIUOnv0j0sU3aaQS0l0tQ9vcYbHXYsmmoPcJunR5mLp5GOlPFcpcdiPrJISInn2C12r2kLitP834WSMZaHPRxXO2+XdAY3te9RZbfWva2cu8PL5OdmYNCw9eNpkZCZmLHZ09va+JljHEAD7ntbB6vk2t8NZtp+0QcXAkZp5TTelYCjPhfdbE/NlqMFozoDlqvf7XaCkP2lO56O5vSkKmIANA+8TQjvSdmcSwG35ml6CQS8+s+mTpGaUSqXexy1+4ZGyEhBaRedqgahu00Nb8LVBPjOQF6XM5t7tIYYy85qrvVtPaTPtSGBhvl/hyNpV5iVsQhW2thwPhjWqDrTR+N9TnaY90wGVZWIxbqqwjrkFNKPN8qebxdQqgxwwxrg5V479ZbiJQtvWT/NZkw3AaqHBE4czUGHw/u3qH60AgiRQQwzWdf8KXeur5ZljhEbW3S2LDXuQ+wDuq9a80gcbMRWiDj9b6x++0z3cOE+dJH9KGKdYwG+A1HroGRg5pbzZcPxe32Exbig2RmFG1+gCcYIbPwuN+o136grJtPqgNc4AThYvVerJx3jbBl4BCpPbjp7Oo3haK4mR+q6sH4LcTcdMJDIKmUaXAGpwVyTkrELEYKUYBIBATxEO49fSramKsGxBIoXt5N8xvrsw00LZI/xkvFzqucdRrSlWu9NLk8Rwbz1geNaWCAwSupE+VuW8TOX8KU5zkc8Xo+R+vU56sdCXIpaljgkdANu29wIHRXFYgjBIhfQNIEXwwF5gyAb3d2FNC5XE8RnYL
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c83e7cb-acdf-4b10-16a5-08db37d2de76
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2023 01:45:01.7951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t7mhs7dnb7tN4LhiQpgW43v5CPPSapC88v/ZmUJNAF/sG2dpaHfZect/0Y8lvfeqQ8FNY9dCgEPhoHbw4TrQvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6663
X-Proofpoint-GUID: K76iNdCxUDz-_98PGVn7JDWDWarqhHXT
X-Proofpoint-ORIG-GUID: K76iNdCxUDz-_98PGVn7JDWDWarqhHXT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_16,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 spamscore=0 mlxlogscore=919 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304080013
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBBcHIgMDcsIDIwMjMsIFdlc2xleSBDaGVuZyB3cm90ZToNCj4gU2V2ZXJhbCBzZXF1
ZW5jZXMgdXRpbGl6ZSB0aGUgc2FtZSByb3V0aW5lIGZvciBmb3JjaW5nIHRoZSBjb250cm9sIGVu
ZHBvaW50DQo+IGJhY2sgaW50byB0aGUgU0VUVVAgcGhhc2UuICBUaGlzIGlzIHJlcXVpcmVkLCBi
ZWNhdXNlIHRob3NlIG9wZXJhdGlvbnMgbmVlZA0KPiB0byBlbnN1cmUgdGhhdCBFUDAgaXMgYmFj
ayBpbiB0aGUgZGVmYXVsdCBzdGF0ZS4NCj4gDQo+IEZpeGVzOiBjOTY2ODM3OThlMjcgKCJ1c2I6
IGR3YzM6IGVwMDogRG9uJ3QgcHJlcGFyZSBiZXlvbmQgU2V0dXAgc3RhZ2UiKQ0KDQpSZWZhY3Rv
ciBwYXRjaCBzaG91bGQgaGF2ZSBubyBmdW5jdGlvbmFsIGNoYW5nZS4gV2h5IGlzIHRoZXJlIGZp
eGVzIHRhZz8NCg0KQlIsDQpUaGluaA0KDQo+IFNpZ25lZC1vZmYtYnk6IFdlc2xleSBDaGVuZyA8
cXVpY193Y2hlbmdAcXVpY2luYy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9nYWRn
ZXQuYyB8IDQ0ICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMSBm
aWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDI0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2dh
ZGdldC5jDQo+IGluZGV4IDNjNjNmYTk3YTY4MC4uMzIwZTMwNDc2Yzg4IDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2Fk
Z2V0LmMNCj4gQEAgLTEzOSw2ICsxMzksMjQgQEAgaW50IGR3YzNfZ2FkZ2V0X3NldF9saW5rX3N0
YXRlKHN0cnVjdCBkd2MzICpkd2MsIGVudW0gZHdjM19saW5rX3N0YXRlIHN0YXRlKQ0KPiAgCXJl
dHVybiAtRVRJTUVET1VUOw0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMgdm9pZCBkd2MzX2VwMF9yZXNl
dF9zdGF0ZShzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiArew0KPiArCXVuc2lnbmVkIGludAlkaXI7DQo+
ICsNCj4gKwlpZiAoZHdjLT5lcDBzdGF0ZSAhPSBFUDBfU0VUVVBfUEhBU0UpIHsNCj4gKwkJZGly
ID0gISFkd2MtPmVwMF9leHBlY3RfaW47DQo+ICsJCWlmIChkd2MtPmVwMHN0YXRlID09IEVQMF9E
QVRBX1BIQVNFKQ0KPiArCQkJZHdjM19lcDBfZW5kX2NvbnRyb2xfZGF0YShkd2MsIGR3Yy0+ZXBz
W2Rpcl0pOw0KPiArCQllbHNlDQo+ICsJCQlkd2MzX2VwMF9lbmRfY29udHJvbF9kYXRhKGR3Yywg
ZHdjLT5lcHNbIWRpcl0pOw0KPiArDQo+ICsJCWR3Yy0+ZXBzWzBdLT50cmJfZW5xdWV1ZSA9IDA7
DQo+ICsJCWR3Yy0+ZXBzWzFdLT50cmJfZW5xdWV1ZSA9IDA7DQo+ICsNCj4gKwkJZHdjM19lcDBf
c3RhbGxfYW5kX3Jlc3RhcnQoZHdjKTsNCj4gKwl9DQo+ICt9DQo+ICsNCj4gIC8qKg0KPiAgICog
ZHdjM19lcF9pbmNfdHJiIC0gaW5jcmVtZW50IGEgdHJiIGluZGV4Lg0KPiAgICogQGluZGV4OiBQ
b2ludGVyIHRvIHRoZSBUUkIgaW5kZXggdG8gaW5jcmVtZW50Lg0KPiBAQCAtMzgyMSwxNiArMzgz
OSw3IEBAIHN0YXRpYyB2b2lkIGR3YzNfZ2FkZ2V0X2Rpc2Nvbm5lY3RfaW50ZXJydXB0KHN0cnVj
dCBkd2MzICpkd2MpDQo+ICAJZHdjLT5zZXR1cF9wYWNrZXRfcGVuZGluZyA9IGZhbHNlOw0KPiAg
CXVzYl9nYWRnZXRfc2V0X3N0YXRlKGR3Yy0+Z2FkZ2V0LCBVU0JfU1RBVEVfTk9UQVRUQUNIRUQp
Ow0KPiAgDQo+IC0JaWYgKGR3Yy0+ZXAwc3RhdGUgIT0gRVAwX1NFVFVQX1BIQVNFKSB7DQo+IC0J
CXVuc2lnbmVkIGludCAgICBkaXI7DQo+IC0NCj4gLQkJZGlyID0gISFkd2MtPmVwMF9leHBlY3Rf
aW47DQo+IC0JCWlmIChkd2MtPmVwMHN0YXRlID09IEVQMF9EQVRBX1BIQVNFKQ0KPiAtCQkJZHdj
M19lcDBfZW5kX2NvbnRyb2xfZGF0YShkd2MsIGR3Yy0+ZXBzW2Rpcl0pOw0KPiAtCQllbHNlDQo+
IC0JCQlkd2MzX2VwMF9lbmRfY29udHJvbF9kYXRhKGR3YywgZHdjLT5lcHNbIWRpcl0pOw0KPiAt
CQlkd2MzX2VwMF9zdGFsbF9hbmRfcmVzdGFydChkd2MpOw0KPiAtCX0NCj4gKwlkd2MzX2VwMF9y
ZXNldF9zdGF0ZShkd2MpOw0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMgdm9pZCBkd2MzX2dhZGdldF9y
ZXNldF9pbnRlcnJ1cHQoc3RydWN0IGR3YzMgKmR3YykNCj4gQEAgLTM4ODQsMjAgKzM4OTMsNyBA
QCBzdGF0aWMgdm9pZCBkd2MzX2dhZGdldF9yZXNldF9pbnRlcnJ1cHQoc3RydWN0IGR3YzMgKmR3
YykNCj4gIAkgKiBwaGFzZS4gU28gZW5zdXJlIHRoYXQgRVAwIGlzIGluIHNldHVwIHBoYXNlIGJ5
IGlzc3VpbmcgYSBzdGFsbA0KPiAgCSAqIGFuZCByZXN0YXJ0IGlmIEVQMCBpcyBub3QgaW4gc2V0
dXAgcGhhc2UuDQo+ICAJICovDQo+IC0JaWYgKGR3Yy0+ZXAwc3RhdGUgIT0gRVAwX1NFVFVQX1BI
QVNFKSB7DQo+IC0JCXVuc2lnbmVkIGludAlkaXI7DQo+IC0NCj4gLQkJZGlyID0gISFkd2MtPmVw
MF9leHBlY3RfaW47DQo+IC0JCWlmIChkd2MtPmVwMHN0YXRlID09IEVQMF9EQVRBX1BIQVNFKQ0K
PiAtCQkJZHdjM19lcDBfZW5kX2NvbnRyb2xfZGF0YShkd2MsIGR3Yy0+ZXBzW2Rpcl0pOw0KPiAt
CQllbHNlDQo+IC0JCQlkd2MzX2VwMF9lbmRfY29udHJvbF9kYXRhKGR3YywgZHdjLT5lcHNbIWRp
cl0pOw0KPiAtDQo+IC0JCWR3Yy0+ZXBzWzBdLT50cmJfZW5xdWV1ZSA9IDA7DQo+IC0JCWR3Yy0+
ZXBzWzFdLT50cmJfZW5xdWV1ZSA9IDA7DQo+IC0NCj4gLQkJZHdjM19lcDBfc3RhbGxfYW5kX3Jl
c3RhcnQoZHdjKTsNCj4gLQl9DQo+ICsJZHdjM19lcDBfcmVzZXRfc3RhdGUoZHdjKTsNCj4gIA0K
PiAgCS8qDQo+ICAJICogSW4gdGhlIFN5bm9wc2lzIERlc2lnbldhcmUgQ29yZXMgVVNCMyBEYXRh
Ym9vayBSZXYuIDMuMzBh
