Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CC06DB80A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 03:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjDHBnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 21:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDHBna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 21:43:30 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845A983F6;
        Fri,  7 Apr 2023 18:43:28 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 337JC4TK008511;
        Fri, 7 Apr 2023 18:43:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=L9wGQ8L2YRCUuFAOIqTwLiF7tu1fEG0boQnOqpf7M0g=;
 b=MLmqkcYoA7cAEu8eWeCQCu4ThI8GRGfLmU8sI32DPppjbD9NCyJ7ygN3GmuBw3JkiAhK
 sq0SeG5842ULKlCzXV0ARWyQU62reBr6+LQnN6uZk/wTAwWPht2I8amnWlAv7WNBSgNs
 FkaN75rfTVVJ2kpCWh7pGgiItR/uXYgoxB6a6UsoO31Zb5Rc+WjO8pSeeMTVy2PakVDx
 5WcP1QJy8AWPc/Zo+oqSXjs4BIFTva6Ser2ojY205dHnYA0HOePfUh+wFiJTXM+FWj8+
 qMudecCeOcPP10kK+2yE2njVTL0Qcd6b9oYKT+ct5kEoWMCuBH3glNpMvgsjrvYVU6hU Qg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3ppkhy7uv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 18:43:08 -0700
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 12420C04C0;
        Sat,  8 Apr 2023 01:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1680918187; bh=L9wGQ8L2YRCUuFAOIqTwLiF7tu1fEG0boQnOqpf7M0g=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=N50Hxn6C0S2gvT+hg0+kWxqV4wRCmDtyUO5hSG3F3ahw5ch54SUbn6b2doAdgdPiH
         3XxSCBRz5zgbDMrzPqSfKUtvAqUIVklzlzjEOFSealxiF5BehCiyEldDav0tFQgHu/
         2kJkA179ZjL9icQbeyFUGe7DgvGoaFNkLt1Fxb1XBPtSDgGOzsU1P8cwobGkYQrX0b
         k1QpHwHM10vEZj91CnBIysvLnpNGXXTrBq03tCuIfISFJMN+xBKVQSf+cHuIxtfPxP
         VysLRTJHNuMWYGm8ymyRnZ4U8DFbifv0gH6GpoZYS7KxQ4TimuRVYqCbzwOU4CUdBZ
         CXrqMWLpsJqTw==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id E3A89A00A4;
        Sat,  8 Apr 2023 01:43:04 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id A6C7940086;
        Sat,  8 Apr 2023 01:43:03 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="sLA4M6M2";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLoMZWV4HLaDXEvPqDbApgjDhb0nym5tBaKPv3IwVup5z89jIXWo1xSMiCPJmi9fR2vZz3VjxIitbBm4amTkE7FG0eip3P88PxR6XYTb7dZngxcbH30us4ThyGKmPUPGKx9WzUeWBhDVjZ7j7PZja5qse3gDqtimFPns4Zvo4pe6f+wjvkL2Nq0OTLkLenCP7+cXC5x8DzJ6O80bVxNgkN0PPrVJswaYgisHvzsH5qX455K7ciUinaNB5Vv8JoIHiaow6g4ie3k1RxvuH7cmqkL/Ew1dgFQrJ5Yb5KZtjaLrcojtXBf2jKt2thIyt6RNIa4dxh447qug8xJWRsxszw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9wGQ8L2YRCUuFAOIqTwLiF7tu1fEG0boQnOqpf7M0g=;
 b=eJmD8j87ET+ezvlU0BSHa7sBuEPF6z9iY6i+EnWpv8GyxdtMLgUOo6VmBUg7Se92PDPqyfd7wJbiLupS7ujhxiR1zcuuq9M5BC1w1rbqY+UuGfoJHR8y7+fRFbP0XMaFeHKIHM9RjwkqfeK8zkl5buvPj6Lf6vYAhKH4hH9+ON5VQEpRX0RRMbyZNH3BYuPCO7OQKkL+d/zbBcBrnfDh38ET8DJ/EvOerDatLdc1oJ2tN740/FPvmnGIpFpSNvSOGN2Z61SkZT5V0naFo3vMDBSYtXHNEWjVepY3eVQxIYLWE5Pa5Z34M1kcPtVEw2rcEghF23qeL19ZwUwIwymvkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9wGQ8L2YRCUuFAOIqTwLiF7tu1fEG0boQnOqpf7M0g=;
 b=sLA4M6M2AC66K7fWF+L8acADh/44g0infWtX/aE1EzMlPDVnifm3xtHrIaQ3npqE5C9cYD2puAlRti/P6wBeh0ViynH7YET8HqOscIbauQ+JcDz2zKGZI3KG3wsCN2tsKIJ0NY9boALVWursz3n9y9Lsdr1eJ7cEHlGNVLHSWZ4=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DM4PR12MB6663.namprd12.prod.outlook.com (2603:10b6:8:bb::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.33; Sat, 8 Apr 2023 01:42:57 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c22b:eb27:6df3:8d25]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c22b:eb27:6df3:8d25%4]) with mapi id 15.20.6277.034; Sat, 8 Apr 2023
 01:42:57 +0000
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
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "quic_pkondeti@quicinc.com" <quic_pkondeti@quicinc.com>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_harshq@quicinc.com" <quic_harshq@quicinc.com>,
        "ahalaney@redhat.com" <ahalaney@redhat.com>,
        "quic_shazhuss@quicinc.com" <quic_shazhuss@quicinc.com>
Subject: Re: [PATCH v6 0/8] Add multiport support for DWC3 controllers
Thread-Topic: [PATCH v6 0/8] Add multiport support for DWC3 controllers
Thread-Index: AQHZZ75ThmrIuVEA5kWTiPsuhxFGB68gp1+A
Date:   Sat, 8 Apr 2023 01:42:57 +0000
Message-ID: <20230408014251.6cyjwuvsgu7dmz53@synopsys.com>
References: <20230405125759.4201-1-quic_kriskura@quicinc.com>
In-Reply-To: <20230405125759.4201-1-quic_kriskura@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DM4PR12MB6663:EE_
x-ms-office365-filtering-correlation-id: bb109ff9-73d9-4ad1-9db9-08db37d29457
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O4frrc59wGFDH3XyLdFnAP9i/+gQtpNg4pIzJaImPH5KUiOH+frf2Oa5CeaksIzYivtf7eK8g0DN7JqU+It5CqkMO2w2AgkV+EpziXglqBIJ6IUsW3fUvbSRNTV6NhGSxGGi083kExPTDEYHyzQzFmmxMFE4gul1JbXMQifql8HrJfK8c5Zqq84rofs0f+26OyqbYnZqNja518GxhDNZIaDb4zf3xP+AfUrfsnOPuEEdxdr3tZQuPEgabyQ2/srPZyi2MawVQNneZMzADwdCPYC1vLrFpx0mZ/ad+VOFaduLcEibwKHpmmeVQSxJijUuTkTqUPphoOWwEK1AKOESr0BLXwGlH4dJzr/30RTYTlRcLE8yJYz4fL8KPrHh4zetDRLXDYbAS1GnaT3clGHB+TGa0mAeXnNGs3fKhIkfD696ahs0t5ejkDyUQHDUIALJrMBOnZNKrhMLMirM/wZt7Ba1Y9JcnxdcajExoWQJg/gocL4/zQaqekMK4RB5hjFV+vD5gUvyej61WzonMeiDcuEEQvK2+g5qpm4AF1foplUadQ7eVDcC33N0W/g+J+I9sZSU/e0tS07oA1Hf/lNTkUXqYonGqlt9k5+V1KbkrznysZP53S8aPlRpqxI02mwWFq2recOH11vmsa+1rmS9Mw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(366004)(39860400002)(346002)(396003)(451199021)(71200400001)(2906002)(6512007)(26005)(2616005)(186003)(1076003)(4326008)(66476007)(83380400001)(8676002)(66556008)(6916009)(66946007)(76116006)(66446008)(41300700001)(54906003)(64756008)(478600001)(7416002)(5660300002)(316002)(966005)(6486002)(8936002)(6506007)(38100700002)(122000001)(36756003)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Uk5nMTM0K1drOVhEU0dNQUZVTDBzTzE0ZUdpZE4vWkJsMzBwMSsyUnNJRVE5?=
 =?utf-8?B?a240U1BXcmFTZDhaNFc1UG8reXNYTFZYRTlkVGlUVVVDeHJkdnROUHRnT2FN?=
 =?utf-8?B?YnJjU1luMlhzd3phWStRMDJzR2ZaSGhMTVZ6MzZRcDk5ZzcyK2o2MnN3WDk4?=
 =?utf-8?B?RnhDYnVwZUlQbzJRWjJTc1JMRzBMSDRXVzJBVlhOWUljSWN4OFc4UjRNTFJ2?=
 =?utf-8?B?MnBrelMzTi9jS2Fqa1ZPemdoQWR2WE95blhaMkpaUUNmTW45Y0FLRnZYYzNZ?=
 =?utf-8?B?ZUxkdGpTQWpiNzNmbEl5ak1odHZLTjdOcjg1SXBUVDcxOW40WW02czA5SUFq?=
 =?utf-8?B?TFRrLzBvVm9JQmtJbWcyKzFHdnFWWTViUm02c0thQVpQK1RmdkhGamhjL01a?=
 =?utf-8?B?VFM4Q21mTGxHTjBLYkNVZEhPaU1DSWJzUGF4ZkpxT2JOSDlZektEV1hvYVRR?=
 =?utf-8?B?cnU1b2tpZytxQVQ3blZRWlVnNGVzT3FNSXVyaWZqaVF4THhCUUNFNkhIVXFm?=
 =?utf-8?B?dFFKcE9ubE1pb2ZRNzVuZHRmbjNFSHd4RnE5enlONVBOUTBwYmJIU1k4bHBr?=
 =?utf-8?B?V0xRM2JwWU9GWmx6N1RWWUlsTEVFaUhyd3FTZENWeFYwcmVFSENqcWVPaWJZ?=
 =?utf-8?B?SFlhTEZZbDBpKzBjSXlzN3hDTGJVOFdaRFFYQmhEajRFRXRKb08rWGF5OGJa?=
 =?utf-8?B?MXBOWFFDZ2pGa2U4ZERURFVaZEtnU0xlOS9TRlRVZTRqQ0ZubEYzaERUc3dP?=
 =?utf-8?B?YXZYN3ZXRTgrVXUxeUVsN29zbVZqalBsaTJuRGxBR2VzNnkxZlBCdis1OXhQ?=
 =?utf-8?B?d1A4SVg0ZVpPK1czckNTbnFOejlZS0ZQd1BMVVhTcm1QVXY3NHhWc1VCdlRo?=
 =?utf-8?B?cnI2MDQ1UHpJWWtEelQvbVBOYThlelA1NjJQTmZKaU9UNVdjenlteFVZVE1s?=
 =?utf-8?B?Y2xNekZWNWtka0s3RmhzN2JoTnBvSU9PNThQMTY5Skh5bmthZkQ2VFJJMlho?=
 =?utf-8?B?ck96NzNMaDV1VFNsbjlQNFFpbTgzRHgweE1VR0o2STVLS2lDcCtZbmNwbUtn?=
 =?utf-8?B?Y29nQS9TYXlhVHRUSkZBbzZVQnpjeHF5QzcxcVBpTzEwZ1lKeUZsNXVEMnlJ?=
 =?utf-8?B?WWUyZUVMRjZzN2Rhc0o5RFNaRWxOZTZodUt4ZXhCZ21FemVPSFpTMHd5MUdU?=
 =?utf-8?B?THFJbFdCTnhvWThOSERtaC9nYmhtVUtQcDdXSU45UmxackdZbnZGUjMwOXBI?=
 =?utf-8?B?L1prY054OVBMazdNLy9qUXd4ZnVHM1NWcU4yOGt0OERVU0pzaGxnSjFpY2xK?=
 =?utf-8?B?ZDhrOHVvNWlJTjRpRjJHaEkySTlJNUs4aDh6QXRZbkxEY0dvVUZWWkVkbWlP?=
 =?utf-8?B?NjFNRmxPOEhlbnBudkh5MGw1Y3Z2Q1drYUJ0d05pditOd0ZQVUR4YUZpR0l2?=
 =?utf-8?B?SEFLTUNRMHFCb1BEOXVjRW1rdkNjUENSVUdzTnRrdEVBL2V3anBoUWYrQkIy?=
 =?utf-8?B?K3VmUHBwS3BoOUR6QU04RGNtUXJzWGMwcFBvNlZFSDg4VUFhbm5oeW9nZTVu?=
 =?utf-8?B?QWtKTXBhUWpURDZoWmxSaHpWU3Y0Z2VVelRMZmpMbUlQbUt4VllBZndrY2xR?=
 =?utf-8?B?MVBBQllvV21HS2NpM3BHZitIQ0RJQnRQZEJFSkZGUkwyRTdaYnFyYnIrcUxW?=
 =?utf-8?B?UUcveGwyVEJlQ3RrSTNNZkZFck00cFpyc3ROQU1yUDkySFl3V1Z5elhlc0Rq?=
 =?utf-8?B?UjdoUU9XMjlSU2N1SzByZWR3VWJramIzb2ora3ZJenNNYVE4dGhEWXl0MzhP?=
 =?utf-8?B?ZElKQnljTFJwV0w0aVNjOEtMRS9UT1VzaEFPMEUyZGpCMWFvU01MQkxoelh2?=
 =?utf-8?B?aGFxbjEwMVpmZ01zenB5Q3hLVXBOV2h6ZVlpdTBDWUcza0VVMUMvaXZ2UytI?=
 =?utf-8?B?ZWxFNWI4MHZtT1B2Vm05ak56Sm9HQmVIRmtoVUhNK3pRQzBkZUdpSXV1L3Jm?=
 =?utf-8?B?QWUyMlZUQng1Nzh1S1kwSEdhbERleUo4UllueFpZY0g2T2Q2dW5Dc0ZaRmJk?=
 =?utf-8?B?eUx4am4zd2JxRkQyeHl6aUg0ZGFQRTdsMHk1bHN5bEpqTTdEaXdVeDg4eVdJ?=
 =?utf-8?Q?FDdSVpmZvhJmpmj6pG/yfhjW9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5AA7AB4D58D7C4419DBCAA68150C6075@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NXAvNU5qU1BsRmNKVndtWE5NWEI5WFdoYzNTVCt5ekNjREhhdFp3dTYwT3lX?=
 =?utf-8?B?M29wQkJ2bGd0Y2NMVmd4MllmbG9EdUlvb25PSklmWkhHa2JZNDU1K2M1L2Vn?=
 =?utf-8?B?SEtzV2xhc0xDYkxtUGNwenVuWWVhSlhWazFxdkVlazF4YnV1Z2pkdTFSOFpv?=
 =?utf-8?B?Zzc0SFE0UXNubFlHbE5GRnNCMitZUkUzdzR0NmY5cmpLWE4xcVlqam5GaFZ4?=
 =?utf-8?B?ZHZXb0sxMG1LdEhLNkJTQjdydUF3dUYrMnlTbTQ3N1pzYndVNlpsTUpOTDdu?=
 =?utf-8?B?S3dSNmprbEFzYmsxbkRrZGpMYVh5M3Z0dEdSaktHT0FMRnl4ei82ZWh6NWcr?=
 =?utf-8?B?Z0M5Skl3RE9EQlVrRDdTL2FqclYrSnZiSm5VUzlrRHR3WXd1K2FQU00zTXF5?=
 =?utf-8?B?aFU2eDVPZHl0T3BJWWVIY2dWWlJhN3lDVUlheTkrYkJPVGIvMzhNei9UbVJu?=
 =?utf-8?B?ektMcVdlUHc5dGk0MGc4M2lEUy9QWVpVbXdHc2c2OU90R1NVWWVPQmF5U0hi?=
 =?utf-8?B?S3pNWDdwRHhTWGN5NTJSNkZBK1BWNUwxZWVOVVdpdFBrTUNhenExUS9tRm9Q?=
 =?utf-8?B?aFhWa3hvMFY4ZXJoYXF5NGhKTk1JOHpKOGI5R2dySndMOFF0a05jV241Nm04?=
 =?utf-8?B?MG9BWlIzRWdQaS9lWHZoQ1puSmUvZXZrM3c0dkZxenpxT1pyYWMrSlpCMGtk?=
 =?utf-8?B?cHIvVkp6eC83aHVoUGtmdy84MDNNQ25HbnR6ZzdwNGhFNTk2MzNvQ0UrYkY5?=
 =?utf-8?B?UDNEWGNrcWw4SW5rT0NEZTlJZGlvUStUaEp0MmdFZnVDRm1BK2cyaERtOWo4?=
 =?utf-8?B?ZFNIWExiSkxrWlpUNHVMUjZWQ1NKVFRiSUpuelJtQzl4OXlkWDZtbWxUVFBa?=
 =?utf-8?B?MUNQeXpIZ3VseVUwb3puZG1yL3hBMk0wUDZQT1lOZzJ2bWNMdGlsaTQ0Wlo4?=
 =?utf-8?B?WEswZmM3ZkpZZXdGOEc0T1kwWDFnSVRrdEszRTdrdUJjVU9oZW5rVk42cWV4?=
 =?utf-8?B?UzF3dXhWdUtFUFNSdGppT1k1MWRTbXNuRFN0bjVQTWxNUDBvWG9ZckpDcEZn?=
 =?utf-8?B?SWR6WENXNHJxVzZXQUUwNjcrdGRTc0RORFdHdjZ2UUhNaDdHbFQ0V3NwNFlw?=
 =?utf-8?B?QkFhemMxTUg4N3h3OVJUdW1VRVdURVdRL0NFcXRsUlVEY0x4dk1BRlh1eUYv?=
 =?utf-8?B?RmdmYUt2WlVUYUxDZndqOHBVRUhpL2FzcnA1cmxadDZLTSs4bVk5L1krWU10?=
 =?utf-8?B?Tk9JUlBhbmZJaVFmaUttY2RKK01obmIxS1AvYmNPWFhHeWU5V1dFalNDelcv?=
 =?utf-8?B?MGZ5bFJ5WFdOQjhCRTltcUtsL0R1ODk3WTZ4K1NuTDdjVllrK2VMdVFzYVJY?=
 =?utf-8?B?RVJXR3MwMGhLNEE9PQ==?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb109ff9-73d9-4ad1-9db9-08db37d29457
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2023 01:42:57.4435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0g7xC4wLM47O093YHI4aFTOPy750SWC0zq33EeZ0YMmH0wrEFQ+GPevjsuUFng7ZUFK4GVUqR0l3cHi333TBSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6663
X-Proofpoint-GUID: iMfLCQ3f23o83jqraqOCHAr3e_fqDina
X-Proofpoint-ORIG-GUID: iMfLCQ3f23o83jqraqOCHAr3e_fqDina
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_16,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304080013
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBBcHIgMDUsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgd3JvdGU6DQo+IEN1cnJlbnRs
eSB0aGUgRFdDMyBkcml2ZXIgc3VwcG9ydHMgb25seSBzaW5nbGUgcG9ydCBjb250cm9sbGVyIHdo
aWNoDQo+IHJlcXVpcmVzIGF0IG1vc3QgdHdvIFBIWXMgaWUgSFMgYW5kIFNTIFBIWXMuIFRoZXJl
IGFyZSBTb0NzIHRoYXQgaGFzDQo+IERXQzMgY29udHJvbGxlciB3aXRoIG11bHRpcGxlIHBvcnRz
IHRoYXQgY2FuIG9wZXJhdGUgaW4gaG9zdCBtb2RlLg0KPiBTb21lIG9mIHRoZSBwb3J0IHN1cHBv
cnRzIGJvdGggU1MrSFMgYW5kIG90aGVyIHBvcnQgc3VwcG9ydHMgb25seSBIUw0KPiBtb2RlLg0K
PiANCj4gVGhpcyBjaGFuZ2UgcHJpbWFyaWx5IHJlZmFjdG9ycyB0aGUgUGh5IGxvZ2ljIGluIGNv
cmUgZHJpdmVyIHRvIGFsbG93DQo+IG11bHRpcG9ydCBzdXBwb3J0IHdpdGggR2VuZXJpYyBQaHkn
cy4NCj4gDQo+IENoYW5hbmdlcyBoYXZlIGJlZW4gdGVzdGVkIG9uICBRQ09NIFNvQyBTQTgyOTVQ
IHdoaWNoIGhhcyA0IHBvcnRzICgyDQo+IGFyZSBIUytTUyBjYXBhYmxlIGFuZCAyIGFyZSBIUyBv
bmx5IGNhcGFibGUpLg0KPiANCj4gQ2hhbmdlcyBpbiB2NjoNCj4gVXBkYXRlZCBjb21tZW50cyBp
biBjb2RlIGFmdGVyLg0KPiBVcGRhdGVkIHZhcmlhYmxlcyBuYW1lcyBhcHByb3ByaWF0ZWx5IGFz
IHBlciByZXZpZXcgY29tbWVudHMuDQo+IFVwZGF0ZWQgY29tbWl0IHRleHQgaW4gcGF0Y2gtMiBh
bmQgYWRkZWQgYWRkaXRpb25hbCBpbmZvIGFzIHBlciByZXZpZXcNCj4gY29tbWVudHMuDQo+IFRo
ZSBwYXRjaCBoZWFkZXIgaW4gdjUgZG9lc24ndCBoYXZlICJQQVRIQ0ggdjUiIG5vdGF0aW9uIHBy
ZXNlbnQuIENvcnJlY3RlZA0KPiBpdCBpbiB0aGlzIHZlcnNpb24uDQo+IA0KPiBDaGFuZ2VzIGlu
IHY1Og0KPiBBZGRlZCBEVCBzdXBwb3J0IGZvciBmaXJzdCBwb3J0IG9mIFRlcml0aWFyeSBVU0Ig
Y29udHJvbGxlciBvbiBTQTg1NDAtUmlkZQ0KPiBBZGRlZCBzdXBwb3J0IGZvciByZWFkaW5nIHBv
cnQgaW5mbyBmcm9tIFhIQ0kgRXh0ZW5kZWQgUGFyYW1zIHJlZ2lzdGVycy4NCj4gDQo+IENoYW5n
ZXMgaW4gUkZDIHY0Og0KPiBBZGRlZCBEVCBzdXBwb3J0IGZvciBTQTgyOTVwLg0KPiANCj4gQ2hh
bmdlcyBpbiBSRkMgdjM6DQo+IEluY2FzZSBhbnkgUEhZIGluaXQgZmFpbHMsIHRoZW4gY2xlYXIv
ZXhpdCB0aGUgUEhZcyB0aGF0DQo+IGFyZSBhbHJlYWR5IGluaXRpYWxpemVkLg0KPiANCj4gQ2hh
bmdlcyBpbiBSRkMgdjI6DQo+IENoYW5nZWQgZHdjM19jb3VudF9waHlzIHRvIHJldHVybiB0aGUg
bnVtYmVyIG9mIFBIWSBQaGFuZGxlcyBpbiB0aGUgbm9kZS4NCj4gVGhpcyB3aWxsIGJlIHVzZWQg
bm93IGluIGR3YzNfZXh0cmFjdF9udW1fcGh5cyB0byBpbmNyZW1lbnQgbnVtX3VzYjJfcGh5IA0K
PiBhbmQgbnVtX3VzYjNfcGh5Lg0KPiANCj4gQWRkZWQgbmV3IHBhcmFtZXRlciAic3NfaWR4IiBp
biBkd2MzX2NvcmVfZ2V0X3BoeV9ueV9ub2RlIGFuZCBjaGFuZ2VkIGl0cw0KPiBzdHJ1Y3R1cmUg
c3VjaCB0aGF0IHRoZSBmaXJzdCBoYWxmIGlzIGZvciBIUy1QSFkgYW5kIHNlY29uZCBoYWxmIGlz
IGZvcg0KPiBTUy1QSFkuDQo+IA0KPiBJbiBkd2MzX2NvcmVfZ2V0X3BoeSwgZm9yIG11bHRpcG9y
dCBjb250cm9sbGVyLCBvbmx5IGlmIFNTLVBIWSBwaGFuZGxlIGlzDQo+IHByZXNlbnQsIHBhc3Mg
cHJvcGVyIFNTX0lEWCBlbHNlIHBhc3MgLTEuDQo+IA0KPiBMaW5rIHRvIHY1OiBodHRwczovL3Vy
bGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjMwMzEwMTYz
NDIwLjc1ODItMS1xdWljX2tyaXNrdXJhQHF1aWNpbmMuY29tL19fOyEhQTRGMlI5R19wZyFiNllu
TklvdjFHUUUwbk5rdzA1c1c3MW4zWnBUTTA0c3QtWS1KNWtzQlVlbDJaWmZXcjlaQV9BRTRadEJB
QUR1Q3BKNEM0UkNyOURpMS1mT2ZxSmsxTzdvQlBEeXdRJCANCj4gTGluayB0byBSRkMgdjQ6IGh0
dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAy
MzAxMTUxMTQxNDYuMTI2MjgtMS1xdWljX2tyaXNrdXJhQHF1aWNpbmMuY29tL19fOyEhQTRGMlI5
R19wZyFiNlluTklvdjFHUUUwbk5rdzA1c1c3MW4zWnBUTTA0c3QtWS1KNWtzQlVlbDJaWmZXcjla
QV9BRTRadEJBQUR1Q3BKNEM0UkNyOURpMS1mT2ZxSmsxTzVwNThHYTdBJCANCj4gTGluayB0byBS
RkMgdjM6IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2xvcmUua2VybmVsLm9y
Zy9hbGwvMTY1NDcwOTc4Ny0yMzY4Ni0xLWdpdC1zZW5kLWVtYWlsLXF1aWNfaGFyc2hxQHF1aWNp
bmMuY29tLypyX187SXchIUE0RjJSOUdfcGchYjZZbk5Jb3YxR1FFMG5Oa3cwNXNXNzFuM1pwVE0w
NHN0LVktSjVrc0JVZWwyWlpmV3I5WkFfQUU0WnRCQUFEdUNwSjRDNFJDcjlEaTEtZk9mcUprMU81
ZUxUU09aZyQgDQo+IExpbmsgdG8gUkZDIHYyOiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19f
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzE2NTM1NjAwMjktNjkzNy0xLWdpdC1zZW5kLWVt
YWlsLXF1aWNfaGFyc2hxQHF1aWNpbmMuY29tLypyX187SXchIUE0RjJSOUdfcGchYjZZbk5Jb3Yx
R1FFMG5Oa3cwNXNXNzFuM1pwVE0wNHN0LVktSjVrc0JVZWwyWlpmV3I5WkFfQUU0WnRCQUFEdUNw
SjRDNFJDcjlEaTEtZk9mcUprMU81Q0FzUDgzUSQgDQo+IA0KPiBLcmlzaG5hIEt1cmFwYXRpICg4
KToNCj4gICBkdC1iaW5kaW5nczogdXNiOiBBZGQgYmluZGluZ3MgZm9yIG11bHRpcG9ydCBwcm9w
ZXJ0aWVzIG9uIERXQzMNCj4gICAgIGNvbnRyb2xsZXINCj4gICB1c2I6IGR3YzM6IGNvcmU6IEFj
Y2VzcyBYSENJIGFkZHJlc3Mgc3BhY2UgdGVtcG9yYXJpbHkgdG8gcmVhZCBwb3J0DQo+ICAgICBp
bmZvDQo+ICAgdXNiOiBkd2MzOiBjb3JlOiBTa2lwIHNldHRpbmcgZXZlbnQgYnVmZmVycyBmb3Ig
aG9zdCBvbmx5IGNvbnRyb2xsZXJzDQo+ICAgdXNiOiBkd2MzOiBjb3JlOiBSZWZhY3RvciBQSFkg
bG9naWMgdG8gc3VwcG9ydCBNdWx0aXBvcnQgQ29udHJvbGxlcg0KPiAgIHVzYjogZHdjMzogcWNv
bTogQWRkIG11bHRpcG9ydCBjb250cm9sbGVyIHN1cHBvcnQgZm9yIHFjb20gd3JhcHBlcg0KPiAg
IGFybTY0OiBkdHM6IHFjb206IHNjODI4MHhwOiBBZGQgbXVsdGlwb3J0IGNvbnRyb2xsZXIgbm9k
ZSBmb3IgU0M4MjgwDQo+ICAgYXJtNjQ6IGR0czogcWNvbTogc2E4Mjk1cDogRW5hYmxlIHRlcnRp
YXJ5IGNvbnRyb2xsZXIgYW5kIGl0cyA0IFVTQg0KPiAgICAgcG9ydHMNCj4gICBhcm02NDogZHRz
OiBxY29tOiBzYTg1NDAtcmlkZTogRW5hYmxlIGZpcnN0IHBvcnQgb2YgdGVydGlhcnkgdXNiDQo+
ICAgICBjb250cm9sbGVyDQo+IA0KPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL3NucHMs
ZHdjMy55YW1sICAgIHwgIDEzICstDQo+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL3Fjb20vc2E4Mjk1
cC1hZHAuZHRzICAgICAgfCAgNDcgKysrDQo+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL3Fjb20vc2E4
NTQwcC1yaWRlLmR0cyAgICAgfCAgMjIgKysNCj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvcWNvbS9z
YzgyODB4cC5kdHNpICAgICAgICB8ICA1OCArKysNCj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5j
ICAgICAgICAgICAgICAgICAgICAgICB8IDM3MyArKysrKysrKysrKysrKy0tLS0NCj4gIGRyaXZl
cnMvdXNiL2R3YzMvY29yZS5oICAgICAgICAgICAgICAgICAgICAgICB8ICA3MSArKystDQo+ICBk
cml2ZXJzL3VzYi9kd2MzL2RyZC5jICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTMgKy0NCj4g
IGRyaXZlcnMvdXNiL2R3YzMvZHdjMy1xY29tLmMgICAgICAgICAgICAgICAgICB8ICAyOCArLQ0K
PiAgOCBmaWxlcyBjaGFuZ2VkLCA1MjMgaW5zZXJ0aW9ucygrKSwgMTAyIGRlbGV0aW9ucygtKQ0K
PiANCj4gLS0gDQo+IDIuNDAuMA0KPiANCg0KUGxlYXNlIGNoZWNrIGlmIHlvdXIgcGF0Y2hlcyBh
bmQgbWFpbGluZyBjbGllbnQuIExvb2tzIGxpa2UgdGhleSBhcmUNCmNvcnJ1cHRlZC4NCg0KVGhh
bmtzLA0KVGhpbmg=
