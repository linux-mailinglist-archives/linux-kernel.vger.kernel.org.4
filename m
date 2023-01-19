Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1579672D8E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 01:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjASAj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 19:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjASAjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 19:39:21 -0500
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7727659EA;
        Wed, 18 Jan 2023 16:39:19 -0800 (PST)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30INIYiW004900;
        Wed, 18 Jan 2023 16:39:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=Bis9gDQajNoqYlu4MUfHPiRN8myrryXOYKEtrcU6A5k=;
 b=fGd5QNLXHHbSnoqsWqLy6WU4B5HD2M5pPBbUtoJ0A3eWC+dioPv+ztUlkkeNWNNzPnBI
 oFlSN7TWbEbzBg0D7zJP1WVKYu5Z8a91m5/m5XGBN6g4d9kJgg7nzV9FsS6gxKMDkFrs
 2/FemBfCLrnECJIIszxk8+YIWmXAiBYkWGYvzmjWsR+1OcnEwXjrYb7wlnfv6l7HCGQg
 Of0/AV0s2tnlsjTbTm+phaXSIakS7FAAuVufCC/K4+sk8rQT6Y+ppVDjOt4fwzzd4lQb
 Ju8hRKrgZ2gvp0iSIcxZwl6PnhwBb4jukxWgXXJ5I83Im5kdaUFXWp8JR9o8Rs5LjaCz nw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3n3uwmhf5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 16:39:00 -0800
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 401D040088;
        Thu, 19 Jan 2023 00:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1674088739; bh=Bis9gDQajNoqYlu4MUfHPiRN8myrryXOYKEtrcU6A5k=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=b4GapqTpOoA340purGH+UcSx4E5Lc4LNuugobus+Z56WcgCWMV/dsl8Vd+Nf50gdj
         dxS97IHH8kAzJMvbktN4SZgSPpQoXT9TTd/ytuPy6Hx1SEtkGYfiQpq4/L7ftoF2d+
         tINYk946xE/TaeoB4a0UA2koPN3SmuIflooPlIaOfonRnwZ5axZx9Fjm9Vw5sWoWBw
         3JcPks66NtQtXdlLYvsFWPGvXoqu+HUHH8MBXGATYbGCVjYOaTBNi8H7J1gzOJ+iZq
         rRIPL11+ZhSVkZXXxDh5UsP4P0mQVSNQnOPzZ1HHWGeESjsCl2TE/gilEyp0cekO8U
         co7wqeGfDsOgw==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 160D4A006D;
        Thu, 19 Jan 2023 00:38:58 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 79AE2800F9;
        Thu, 19 Jan 2023 00:38:56 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="nbKY3S9P";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IEQDlb9THQ3KBdz11TDxJWXNYeuAPwEkf4QNTmOENwHsDsYDyCVaG6xcrIYwhZC4FMlxo0XLT8keMHC5PrCGvS9lWD6gS5hDQq4d92XJR5fJkiH4OBTwHvg/JRiiB6iICdqZDbfONXU6J7J67xFDVu5M/nt6ROEH2UA3Vd6vzM+J0tRbK6anWPXciAfpsa3aLwciflF3MglHN5l4dut9qa+eJl0w2Ic3/oNudtihbp46nn0dSdtNRV0Yb0CnLImqbHxojKxhsKXtmH0mte+UftCpTfmQkLfirVujCqZImUODhnpVf8kbZEJUj06RMD3fKU7OirksP/brf3pAh+HfCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bis9gDQajNoqYlu4MUfHPiRN8myrryXOYKEtrcU6A5k=;
 b=ZaaL/QuOQPZcxhqMfb6pJy/I/3exsfF+9p6tQlcQnMvU+HV6t1k+Wo46FsUCcKDqkxk7RMY6sFb1eYAvg0lncm8ofBj/7xRmr5anukTRKfVhdZx2spU6GeirYunwOThaiENCQfxPRUPtoIqaI5YbOigcuIfFSJbKXWRHBOdn0+H399+k1hY0Yij9f1OCfTNCVkq6Z82QIhJ4bBHDOaucp03DZb2L47wu1VOv5AD+ewmytT5uPGx34g5f7af79jUwxQeGMecZqcl0UTCiWRULprha0t7cqj7VyTOGny0J8jEF40GZPDigr8hvKcWGHurzFxZ5+SqHDizC+U9kUcf4ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bis9gDQajNoqYlu4MUfHPiRN8myrryXOYKEtrcU6A5k=;
 b=nbKY3S9Pzj3NXLopApiYOqm2FR1PnMZ66PtSqyrv4In86yGBW+XFp2X2QnHosg8iJATGnj66nHnzvCEF8QGUIYJBRX17xjR6tqd1Ky6txYg4HKpQsEIwy8VgQBjGrVgL0uZ8cWyVyG4VfcRnArUT3YLkBhlx37+h3CnlXXxeCII=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MN2PR12MB4255.namprd12.prod.outlook.com (2603:10b6:208:198::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 00:38:53 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::e395:902b:2e90:b7ee]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::e395:902b:2e90:b7ee%4]) with mapi id 15.20.5986.018; Thu, 19 Jan 2023
 00:38:52 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
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
        "quic_harshq@quicinc.com" <quic_harshq@quicinc.com>
Subject: Re: [RFC v4 3/5] usb: dwc3: core: Do not setup event buffers for host
 only controllers
Thread-Topic: [RFC v4 3/5] usb: dwc3: core: Do not setup event buffers for
 host only controllers
Thread-Index: AQHZKNZzK80dA+KuD0GE1952O2kzEa6k6x8A
Date:   Thu, 19 Jan 2023 00:38:51 +0000
Message-ID: <20230119003850.id3gtcokdim5pvf7@synopsys.com>
References: <20230115114146.12628-1-quic_kriskura@quicinc.com>
 <20230115114146.12628-4-quic_kriskura@quicinc.com>
In-Reply-To: <20230115114146.12628-4-quic_kriskura@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|MN2PR12MB4255:EE_
x-ms-office365-filtering-correlation-id: 6f6018b3-6782-4b54-6685-08daf9b58990
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cmn9psRbGQqNuOVqDoIJ4Bn/Q8Wmot1FPjSwIMvIk2cNYS+HR4E7wrln9Q5UsWgJLguS5XKqHt3xRY50RtMG+ZwmBIndCd/l0Xm+RfLEWVRE07Syrw/tNWL1yr6Px/6T/JEAtYr1JTBhp4FYOXTv256EZOuuXb/lsmK8S89uBL39LXMOAaxiS5BNCNaq7jdVqNYG0X0s8h5etOW4QeyGbta0BTb9/tZ+80xbjfpIrNc+J/7M6xVDHTYpPpJEjgiDvFuO7LKn7CdHX98SORZFnWFPARx7eZBkCkUML526GGQyXlU8shRQuKj1J4QzCiuydAKJ5gnJDzHIH3wrS4E+Bnt28yLkW+gpK+gKnDnrsDOyb66ddhQY5BJGDE9qiEqQ5cQvzFUztfveq+CxBJtNPdKqQYRFGgnaKDGVIHG0JrnQS2MzPTa/WtOR6yA+RDSw4wB0mYfgFC8gijBAKHLaZGyEUoSiGH2F+v2DAdBoFM9CHVlTCbDqhbAc+8Wl6jkoxsJ1dUEPmXJFyh9wihXuCycwlFyajU2GWWEptyekGqZfePTt5n8lEAIpZslOqNkeihPfFCyFH2H6cAxxlZbrgrkR6TAwcZeU6Ptx5GPzz+MV0yZUmVRGVZGdMLVMzWTtxvb1QezmtmyQcVi+JsU9qPE8Vh2hao5vC/zzkyZaJ7vKk6QrUMYpS2hJCvBd5Cja24dtS+WOHYD7PgmpZZ12xg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(39860400002)(376002)(346002)(396003)(451199015)(38070700005)(86362001)(66946007)(66556008)(7416002)(5660300002)(66476007)(8936002)(2906002)(122000001)(76116006)(316002)(38100700002)(64756008)(54906003)(71200400001)(478600001)(6486002)(6506007)(36756003)(6916009)(41300700001)(8676002)(4326008)(66446008)(186003)(1076003)(83380400001)(6512007)(26005)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlBzMmZqVmdNYmlkNXU1dGtHbEFqZWEvRHZVR25vV1ZHbWFlYWtxNGJyak9n?=
 =?utf-8?B?bHlkWHF5dFlhSDJXVFFZNnNTOEJKM2VjaDlHbmovSEJxYTNNdkNrUnducE1t?=
 =?utf-8?B?UGQxMUtFczlFYVVtc3Z1TDB2aEVhTm5XQWJuZE4zeFUyeDFiU1IwZm4zZUt2?=
 =?utf-8?B?Mk9na1RpTzhTS3F4aG5ZRllFQTE5TGVtZEZXcWxqV1dYQ3FPN2syUXpOaThG?=
 =?utf-8?B?SWRxTjE3UDlnYU9EUTdSSWtyb1BUY0lTMHpjZTV0aURjWDl1MWtGcGJySjFB?=
 =?utf-8?B?ODhKRkg5VFE3NlAyNndFVDdjTXdUcnB0RUZHdmVGT2dCd3A5RXlCRHNNVjcv?=
 =?utf-8?B?UXQ2dEFreERMWlVZUHNBaEdjUkI3aFcvNUZkWHBBS0ZnZXdEN3VzWDRGcURj?=
 =?utf-8?B?MEpKZy9Valg3RjJvRFNqOVRCTzB3UXBaQWNzeXFuOWFBcVNDeER0eC9odFE4?=
 =?utf-8?B?UWlVV0l5eEp0R0I3WDR2VXhOUmdUNnl1M2FYNnJ4VjRsb2dLQWVzUThsRDBh?=
 =?utf-8?B?ZkRucGdwTG5SRDhFdjFmRndFbWh5Y3ZEdjA1c0htMXlrTFUxblVmUDlxc0lP?=
 =?utf-8?B?N0xCSXZHS2cxMnQxWTFpeUNzaHdraG9XZUVhUlhtMUdQNjg0emg3dkxoKy9G?=
 =?utf-8?B?L01YaVlhbXp5UTdFSlQvdkJLL3RwcW41RkR2SUdlbUV4YldBZVdnU3UxUjho?=
 =?utf-8?B?MmpaT3VUcFRXLzVqNDRGTk9TSy9LWlZDcEp1bTlCU0NyNWxvblprcVU5SGFu?=
 =?utf-8?B?UVVxQ2JyTUliTlNWcmplQjdaU1FUZnFzaDBJL2J5UmpZb0pEVXAydEFQN2R0?=
 =?utf-8?B?ZkZVSlVqUVMxRkN6ZzdsTyt5Z2NrTE9MMHpZWmZpRGFUaGc1QSt2SU1hSk10?=
 =?utf-8?B?eDRKOVdOZ3VVR0x0V1NmVFRvOGMxWGpBNXgra2Uza25pUHh5VSs1cDJyb0o0?=
 =?utf-8?B?WjF6RFZuVjBqMGZzQjJtUWJlbGR3bWV5OWpQWVJ6QmRMWkc0YzMwYmYxYkdI?=
 =?utf-8?B?VVJIZ1MyYnQzMi9LUDMwa0x5Q2pEM1FKenRsS3NqUElONFpHRS8zQU1wVlNC?=
 =?utf-8?B?am5HZTBNenNuVEpYUFJxZVk1S3RlZFlORjViYW8rblNtbGl6anVCcU9KaklN?=
 =?utf-8?B?ejhsQTg1aC9kMXd5eHhEKzZxQm9uOW1RZXRET3VuUFpKOVpoZUhPenJUZWZq?=
 =?utf-8?B?TUpZUElzWmxSdk1UMXNtVXVCVUNmdzFNUmQ4N2prR0MvbHVnRFRicW1RVXRF?=
 =?utf-8?B?dVhKOHRSNy9QUXNsN0oxdlNKRGRTekxrTTVnY0RTN09vczM3dVg4OXBpTDZR?=
 =?utf-8?B?Y3M0R0NDU0I5d3AwNWVtV3BVRWxXdzBqZVorL1ZYY3hVektCU0liUEd3ekJQ?=
 =?utf-8?B?K211T1BsMjQ3YkcyRjhYaVIvcjdQWGtBbjgvLzZ2RmpLTnBVQlVzWFkrY1ow?=
 =?utf-8?B?WUJpZUpLOUFDb3QxZUtFcnFwZ05jeHI5a01lT3pTelA3b3pPWmNLZlRqMFhE?=
 =?utf-8?B?cENaV3JsNjFJanVRclJ6UUtNck00NWd5UENxVVFaTVFQczltQy9GQWlJSkEx?=
 =?utf-8?B?ZmZIZ21YSU5lSFQ3Rk5Objl5RzZRMkRsMzRSZnF1cXdrTGI0TWVVaURHbUVU?=
 =?utf-8?B?Mm9lQmdQUUFZQmVhaVVEYmx4bU50UWVBY3R1SGtZZkx5bldUQXFGb0xXVHE2?=
 =?utf-8?B?dGUyQ2pmeEJwSVl4NjlrYXpGcDNTKzc3cGxaRkdMbU9oWXVObnJYdy9pOXZZ?=
 =?utf-8?B?emFmMCtlMXZvNjZDNHBDLy9OVFhzb0g5ckFDVFRsS2pkTmlNQ3NrWjQyN2JO?=
 =?utf-8?B?TXVGbnV5Qnk2N1dZWnhPc3IrRVR2Q2xhRlhIRVJzOFBKTnRCUW1aaUpZMWIy?=
 =?utf-8?B?WFFxN1NJVUF6Z3lEaFMxVjAyUEI0c2dxN0VvU1UyaW9PSG1IUmxOYngraHoy?=
 =?utf-8?B?MFUwRGpZdlVzSFJCOTRYMkUweXZsMGVZVFhIeW04OFpqVjFUbllEZFQ4UFRW?=
 =?utf-8?B?U0xDa05uU0VKakVsOEFjWWdrUWxOaGlIdnA4eW93aE91THlnVDRFSU9WME5w?=
 =?utf-8?B?ZlJPc09LbmRhdjJFM2I1bFA1UmVMUXFiaDZEY2JBYzF6SC9XSjk1bUVIaitC?=
 =?utf-8?B?Q2Z5NWVMUDI1TTZuZ29QU0ZqM29qdVg4K29PTUtsaXRqcFlkOGQrUDlyQXd2?=
 =?utf-8?B?NUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <84C4D9542A45544CBE4E38D82A288362@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?K2hUdXpXbXdlUHZ6SjNqR3BsUE5TSndFSTNDTWovenNUQ2NwK0ZqdktzazZR?=
 =?utf-8?B?OWtnZ0JEMys5eTF5WEtwcHZMV0tBUFU1RFR3QlpoOVpjYlBRT0dRMGJUN1Zp?=
 =?utf-8?B?aSswOFZ4Y0xyWkNHRU44NXBEdXZWYVNOb1FnYTAwZTZaNGo2c00yVmhJbm8v?=
 =?utf-8?B?eTJXVUZKbXpaY1YyTlcxNFhPTE9NeFJjRE5wazNHNU9LOG91Z2cwWS9VZDVw?=
 =?utf-8?B?V1l4UmdoSnRMY2dzelVsNW54WjR2SHhmWUZrRXhzWnh5SklYVjI3ekh6ZHRC?=
 =?utf-8?B?MFNmUDVBSnpnNlM5OTBmRndobjhmUS9YK2F6TmhPYWd2Q2RkOXA4WUgxamVw?=
 =?utf-8?B?aVBBZE5VRWh3WnVHWlM1bnVVNkpzM2RUbG5JSWJaNzNib1hvSC9waWorVjI5?=
 =?utf-8?B?UmEzcXRQcE1WbVVOSjI1NjEyOHJtZ0pjZFRZM3FYaVdJdDhtMWRZeGRSeTk4?=
 =?utf-8?B?SGt4ZU9KSGE4TkVEbXdXdTRMSDNkQkJhc05qeHlRYnJOZytEc2xEeGx1RFB5?=
 =?utf-8?B?OTlFcm9UR25va2Uwb1pCOCtPSm5NYmh4bzdtb3ZwTGpTUG9iSmEyUVFsek1J?=
 =?utf-8?B?U1JHV0U0V1JnV0luRTVLRzY5cW45K0I4azVxQ29qQ2VXdmZlNUpGbXBLWnVj?=
 =?utf-8?B?R2FyMGc5MmFyNVpMQ09RQ1VCekZIVFJxQlU2Z3p1UTZzeEI0cWx4WU5jakxD?=
 =?utf-8?B?WjlsNC9pWWlKMC9qZnhDQkZ4SStzeVBpK1MzMjUzeHhueEJWNHVkMExISjFC?=
 =?utf-8?B?T2JYbGtTdnBuOTBDRzVMUTRkaVNpR2ZwcFN6Y1BDbWtlU0d1MVA4MFZtNCtH?=
 =?utf-8?B?d05LNUNQM3daL3ZvdE8rckFzanBSc2g2VHpiV00xZGNDSjZuR1pQWFcxR3VM?=
 =?utf-8?B?RHZ1M1FKVlBXZTRmU3ROdXRKQjZEY1NMTmcyS1FNZGdSaC9UVEYveHU5U2E2?=
 =?utf-8?B?cGNhd2UyZG42QVpKczl6MDNCelBwem5oQXVHRi9IL2lkU3FEckVyV3ZWeXdH?=
 =?utf-8?B?a2dENFNQQTNWampZa1FRWFVnTGVvcFp4YUEvbFJsYVRPTGFtdHVDTkRObDhv?=
 =?utf-8?B?bDd1YjdOclNuMXBQTWUzdkNWdmIvK0I2citQeWp4c2xNeWFhc1BpMm1vRnI0?=
 =?utf-8?B?VGxMZkpqVFZvYW01NTZKT3ptbThxY0dQdVZ2d3ZCM0xUQmJvSHVmaXd0WG9o?=
 =?utf-8?B?eWtaS3U0TFRPcHlPOGFITmhqekQxOFhjNzNFRTc4dzFIYVNEU2kyQU1ZSVB5?=
 =?utf-8?B?VXBxL0VYQkhlMVlZOTV3RGFWelhVT1FTd0E3Q1IvMGQwdG9xT0VMWFNBRk1Z?=
 =?utf-8?Q?heUMr7ZRylkzE=3D?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f6018b3-6782-4b54-6685-08daf9b58990
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2023 00:38:51.8060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HH8EGdYtXLY4MYYLY3q5XLlLKBcJIgX1T//XcXsFrAE05E/WZurv97vHf7wdo+V6d/b0jH+79lZSTWh5AI+A1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4255
X-Proofpoint-ORIG-GUID: yKU-xA9jDnPNX5yAaqyFa4dpJpVpVDAQ
X-Proofpoint-GUID: yKU-xA9jDnPNX5yAaqyFa4dpJpVpVDAQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 spamscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=748 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301190001
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCBKYW4gMTUsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgd3JvdGU6DQo+IE11bHRpcG9y
dCBjb250cm9sbGVycyBiZWluZyBob3N0LW9ubHkgY2FwYWJsZSBkbyBub3QgaGF2ZSBHRVZOVEFE
RFINCj4gSEkvTE8sIFNJWkUsIENPVU5UIHJlaWdzdGVycyBwcmVzZW50LiBBY2NzZXNpbmcgdGhl
bSB0byBzZXR1cCBldmVudA0KDQpJIHRoaW5rIHlvdSBzaG91bGQgcmV3b3JkICJwcmVzZW50IiB0
byBzb21ldGhpbmcgZWxzZS4gVGhleSdyZSBzdGlsbA0KcHJlc2VudCwgYnV0IHRob3NlIHJlZ2lz
dGVycyBhcmUgdG8gYmUgc2V0IHdoaWxlIG9wZXJhdGluZyBpbiBkZXZpY2UNCm1vZGUuIFRoZSBy
ZXN0IGxvb2tzIGZpbmUuDQoNClRoYW5rcywNClRoaW5oDQoNCj4gYnVmZmVycyBkdXJpbmcgY29y
ZV9pbml0IGNhbiBjYXVzZSBhbiBTTU1VIEZhdWx0LiBBdm9pZCBldmVudCBidWZmZXJzDQo+IHNl
dHVwIGlmIHRoZSBHSFdQQVJBTVMwIHRlbGxzIHRoYXQgdGhlIGNvbnRyb2xsZXIgaXMgaG9zdC1v
bmx5Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS3Jpc2huYSBLdXJhcGF0aSA8cXVpY19rcmlza3Vy
YUBxdWljaW5jLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyB8IDIzICsr
KysrKysrKysrKysrKy0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygr
KSwgOCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2Nv
cmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IGluZGV4IDdlMGE5YTU5OGRmZC4uZjYx
ZWJkZGFlY2MwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiArKysg
Yi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBAQCAtODcxLDkgKzg3MSwxMiBAQCBzdGF0aWMg
dm9pZCBkd2MzX2Nsa19kaXNhYmxlKHN0cnVjdCBkd2MzICpkd2MpDQo+ICANCj4gIHN0YXRpYyB2
b2lkIGR3YzNfY29yZV9leGl0KHN0cnVjdCBkd2MzICpkd2MpDQo+ICB7DQo+IC0JaW50IGk7DQo+
ICsJaW50CQlpOw0KPiArCXVuc2lnbmVkIGludAlod19tb2RlOw0KPiAgDQo+IC0JZHdjM19ldmVu
dF9idWZmZXJzX2NsZWFudXAoZHdjKTsNCj4gKwlod19tb2RlID0gRFdDM19HSFdQQVJBTVMwX01P
REUoZHdjLT5od3BhcmFtcy5od3BhcmFtczApOw0KPiArCWlmIChod19tb2RlICE9IERXQzNfR0hX
UEFSQU1TMF9NT0RFX0hPU1QpDQo+ICsJCWR3YzNfZXZlbnRfYnVmZmVyc19jbGVhbnVwKGR3Yyk7
DQo+ICANCj4gIAl1c2JfcGh5X3NldF9zdXNwZW5kKGR3Yy0+dXNiMl9waHksIDEpOw0KPiAgCXVz
Yl9waHlfc2V0X3N1c3BlbmQoZHdjLT51c2IzX3BoeSwgMSk7DQo+IEBAIC0xMjQ2LDEwICsxMjQ5
LDEyIEBAIHN0YXRpYyBpbnQgZHdjM19jb3JlX2luaXQoc3RydWN0IGR3YzMgKmR3YykNCj4gIAkJ
fQ0KPiAgCX0NCj4gIA0KPiAtCXJldCA9IGR3YzNfZXZlbnRfYnVmZmVyc19zZXR1cChkd2MpOw0K
PiAtCWlmIChyZXQpIHsNCj4gLQkJZGV2X2Vycihkd2MtPmRldiwgImZhaWxlZCB0byBzZXR1cCBl
dmVudCBidWZmZXJzXG4iKTsNCj4gLQkJZ290byBlcnI0Ow0KPiArCWlmIChod19tb2RlICE9IERX
QzNfR0hXUEFSQU1TMF9NT0RFX0hPU1QpIHsNCj4gKwkJcmV0ID0gZHdjM19ldmVudF9idWZmZXJz
X3NldHVwKGR3Yyk7DQo+ICsJCWlmIChyZXQpIHsNCj4gKwkJCWRldl9lcnIoZHdjLT5kZXYsICJm
YWlsZWQgdG8gc2V0dXAgZXZlbnQgYnVmZmVyc1xuIik7DQo+ICsJCQlnb3RvIGVycjQ7DQo+ICsJ
CX0NCj4gIAl9DQo+ICANCj4gIAkvKg0KPiBAQCAtMTg4Niw3ICsxODkxLDcgQEAgc3RhdGljIGlu
dCBkd2MzX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJc3RydWN0IHJl
c291cmNlCQkqcmVzLCBkd2NfcmVzOw0KPiAgCXN0cnVjdCBkd2MzCQkqZHdjOw0KPiAgCWludAkJ
CXJldCwgaTsNCj4gLQ0KPiArCXVuc2lnbmVkIGludAkJaHdfbW9kZTsNCj4gIAl2b2lkIF9faW9t
ZW0JCSpyZWdzOw0KPiAgDQo+ICAJZHdjID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCpkd2Mp
LCBHRlBfS0VSTkVMKTsNCj4gQEAgLTIwNjMsNyArMjA2OCw5IEBAIHN0YXRpYyBpbnQgZHdjM19w
cm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgZXJyNToNCj4gIAlkd2MzX2Rl
YnVnZnNfZXhpdChkd2MpOw0KPiAgDQo+IC0JZHdjM19ldmVudF9idWZmZXJzX2NsZWFudXAoZHdj
KTsNCj4gKwlod19tb2RlID0gRFdDM19HSFdQQVJBTVMwX01PREUoZHdjLT5od3BhcmFtcy5od3Bh
cmFtczApOw0KPiArCWlmIChod19tb2RlICE9IERXQzNfR0hXUEFSQU1TMF9NT0RFX0hPU1QpDQo+
ICsJCWR3YzNfZXZlbnRfYnVmZmVyc19jbGVhbnVwKGR3Yyk7DQo+ICANCj4gIAl1c2JfcGh5X3Nl
dF9zdXNwZW5kKGR3Yy0+dXNiMl9waHksIDEpOw0KPiAgCXVzYl9waHlfc2V0X3N1c3BlbmQoZHdj
LT51c2IzX3BoeSwgMSk7DQo+IC0tIA0KPiAyLjM5LjANCj4g
