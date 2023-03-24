Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA9D6C8535
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 19:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjCXSgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 14:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjCXSgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:36:18 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E058512B;
        Fri, 24 Mar 2023 11:36:17 -0700 (PDT)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32OHr9j4018522;
        Fri, 24 Mar 2023 11:36:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=PmExL6R/LT3cO6T4bisicgqWWa56xuxg87L1hr4m5eQ=;
 b=UX6yn4iVxqPrryE1r29IcTU82XALL3Qx9ENztysUWnaCM1lr2xh2HUM8WuMXCuSDQ9OW
 cJ6UuNNLyvF0WohcjD1WLZ5SgLq81BUwviNXBJRX+qpPyAWouolyUBM9VIZ31iIAFMpl
 K9ad3UGK4qt7R2qDkkSLumtdv+ITmxkYv7ZfYRP+31QpBwvvQk3kQ1f12j0cKTwLmkpJ
 3IeDZGZ+E+GC2DAGs6n7MlcgKfXhYWZfZBJRy0odi1lxLrjMkGOi8Ld+tRvFUVWfU55J
 j0MVn1B3p8xFAXraJwxpW+62h4Z1tDwXi9cf4dfJM9+MDQBhPk1i5KIPlgP5xVtk2cHq Bw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3pgxunwd2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 11:36:08 -0700
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CC8F640105;
        Fri, 24 Mar 2023 18:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1679682968; bh=PmExL6R/LT3cO6T4bisicgqWWa56xuxg87L1hr4m5eQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ktuKaxCaY3vrx1VUbV0CHVuagqB7Mkqc4Tpjx9aPFjwT7hCNv3LBBStQGWccIZ+JM
         rvVCXoW8ZLW1hkqsaCyBwqhOmDIiLnb5/lh9obIC6RwPxl1+8qDSpqP5F2lBHsY6k3
         Wvsw00Ss5qsDYBpXNfBxiM2m9ZHJGhECYm2lha2/zLX//5g4XVDG6LWcz0K9ntbH/3
         7wHgL+BVMnIxjHw3rGZKuWSLtMIOY7VqSUa71m/y/41mtRa5dCCtVtbyu88VYCiwQj
         wzyb5YT0UyTuAhb9+35QM+9uGhFHfHlYvapeyQq9QUdzvOI7+EPtoCK4wU9hbyfSIt
         9c2640shPfrvA==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 6ED18A005A;
        Fri, 24 Mar 2023 18:36:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 15A0240060;
        Fri, 24 Mar 2023 18:36:06 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="dtLkV4JX";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TaHoh5d4sCHs0rZOed21adWYZeKXKHHnPn8tidTh4p5FVeWN48yICxpIz/X6eSWBb3F31QQI/F8iKHEDT7ll0qYtrDHMU8dHgX6bXqFtVl1rALI30ML2dWaeNPvaEyTRGPzTRuX3RCjroPQzw0kaSddwYRr9ZRj9D4JWO/ypOm9ZcuD5G++jaTtp+rklUcQzExj/5DSCNW0iXToWNO5Z8kGfnB5PrZvC8b64JPbOiE/eRa9d9lo7GTJl1za+sTH7gxCAYr8KvaBrdlk2xhIZ+/5/Nx4C05YMP2OaJvwbCMgtRNnA2aJ1204V1xQALFFbqy9lFm16MdD476woOSn5LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PmExL6R/LT3cO6T4bisicgqWWa56xuxg87L1hr4m5eQ=;
 b=JIrnAmicubnZnCLGJwZclE1Twn0uOVzoj14GsDZXk6MeDVnwGGdNrZba5fZ9v/nxXu8bbe4ltcVClYbcXmEf9mEmDheVALYh+vnrzkG1l1XGuXlD5zQGmjvnf7NPv6XmiBWbloh+yZNg3jNQDfmsBYtYlCphTeHA43xH9nQiFaICNObSSSBrAGqXF2YbnbPg9PhXRddtjPlXvHiYFulS23AOaWd9CxTfZ9GarBMZTnLbkZ8+YrZcQlr2HO65ZAz1ywV0w3kBQe8phy3lL7tbATrtI8Iravuq4XEYg1kc3cDqa/JZglaYeuCjpb131nIl/u/1sUWn0zVv//cnjAP2bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmExL6R/LT3cO6T4bisicgqWWa56xuxg87L1hr4m5eQ=;
 b=dtLkV4JXPkKtnV5I/zF2xudLQ3OAp1+57mfoh6WeMrr/Tol8jgjMlOdOFDyaFnmk5dZsXapNog/cdYj3MJ7tkb5JuLylPF5lGGOg+eF8sh4pSrJcaoc98aQ7aZOy/q3ZfVWfnXsIdB3UR+9934+LjNc6lDaCIv1QD42ZeyZO850=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by PH8PR12MB6964.namprd12.prod.outlook.com (2603:10b6:510:1bf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Fri, 24 Mar
 2023 18:36:04 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::3161:c44d:8bb3:423f%3]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 18:36:04 +0000
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
Subject: Re: [PATCH v2] usb: dwc3-am62: Fix up wake-up configuration and
 spurious wake up
Thread-Topic: [PATCH v2] usb: dwc3-am62: Fix up wake-up configuration and
 spurious wake up
Thread-Index: AQHZXkYNLNOBXjEAaUWpUx0tNzI6zK8KQmqA
Date:   Fri, 24 Mar 2023 18:36:04 +0000
Message-ID: <20230324183601.pyt7od36chdv2wkb@synopsys.com>
References: <20230316131226.89540-4-rogerq@kernel.org>
 <20230324114429.21838-1-rogerq@kernel.org>
In-Reply-To: <20230324114429.21838-1-rogerq@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|PH8PR12MB6964:EE_
x-ms-office365-filtering-correlation-id: c393ad99-e4a5-4d75-3104-08db2c969fd8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qj5p0cA6jFnYVSf77obmzCtybJxidpFya7VqcEM3pfviqxqYlyjO+rbX/JcjsXmB6e9OB8HRNBZ4hXAco3x9WUCpeBiiXMZ/YAH19QQ7tEEnCsFmb8JmF7nA32o/RDe22N7dkKb7e68gKcl+kE0YYuGIpDZvL7EU2a6zI0JEaTHqzOFYinoqQ16bOrIzjER3ueMUGIZtCRm8dIfBikQAF7tsXbemkxn+g1fzylAYzwdlF8Dy0rU0qt1JBefvydt9RHi0hSuYYuEX/uCi0ScefsFM1vmpnxZn4N1y4z3s39uCdxAOTROqsJ3iYUNVevvSzsErbXMLzInltrGTWe1vq3sz9kiALqJmuXyDMz/fPVWrIB6xE1jLPOHLRLLnWXVSBHgxhan0YR354BI8jVhEQB+09TWI+H529T12xjsGtRNr66y7h/Aoep+vuSdWZ2zWItDfYs+fDVLGgk33/8DZA7M7B2vCcgROMm1eg32d4LzH8EFrfoc1BwIoYvW3crvb+yWXXOMtQKAYxNXQOdvVOk56pWovYIYQs2zLFryjRr+2sdbfpy08Q3k9HzDZ6nU7Dz1x6to5LJvT8Zf6QhtCv71Xh0iQPR0IfRpcyFXOra/8Gr1Bs1z3uPVpqQM4HnxWCQx7qG5Lzf4P8xxcEtAnak9CWrtvEn4qeolwF5z1QZ4Yxz07NWbsOtgqgMbV6f3bdA5LvGGANexFPR2Teb6sww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(366004)(346002)(136003)(376002)(451199021)(54906003)(2616005)(6486002)(1076003)(26005)(122000001)(2906002)(6512007)(83380400001)(41300700001)(316002)(4326008)(66556008)(66946007)(76116006)(8936002)(64756008)(66476007)(478600001)(6506007)(38070700005)(5660300002)(186003)(66446008)(71200400001)(36756003)(38100700002)(6916009)(8676002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTlub0hCNU9DbUFqQ0xrazUyVHRGWkV0cXRPRUdxTzUzQjAzRVZRQ280Ynpw?=
 =?utf-8?B?NDFyeTlqYlN6aVVpY0tHcFZQc3ZKMzYyZTNDcHJLQThvUEpNbWpBaG0vSTF0?=
 =?utf-8?B?ekg1VUYxZzBlQjMrbVJPcGJrb0NlaXJMTENCUDFuTHZrMjlvcTlOUVJWSlVn?=
 =?utf-8?B?VnZReVdEdnNvK3FaTGlOaDdBWHFlaEJ5TU5WaCtoWElYQUQ2M3dPaURDTlow?=
 =?utf-8?B?bEFqUnB5VlFZT1p2dERNUlUzN2dHQ2gvMEtaRHZaNEpEcWVCbjM5SEFvc042?=
 =?utf-8?B?am0xempJZmlSdThFU013KzdqR1l0S2ZPTE51QU95UTRvTDRFTDYydXBpRHN6?=
 =?utf-8?B?aUIySnlacFRMK1pSMVVmSUU3TWtXL3RTSmhYUC8vazBEWjJLRnFxWituNkM5?=
 =?utf-8?B?M0NBSXNuU0JESm1zOXU0N3dkN2JJUDdSdjFRNU1aUEVORUtYSmFaeEI1TDNN?=
 =?utf-8?B?Uk9hR3hkeGU4K0F1WTN1VmlSMHVPbHJhN3Nrb2EzbWFtVWRPODRYemQ5Rng2?=
 =?utf-8?B?YXBjL2p0dkMzakxQMklFRTFlL3FLa2twUlU3cENjWG4rQkkwaWNZTGgwS3l4?=
 =?utf-8?B?V0wyQlp6TklvWHEwK0Y1QmhLNHFsanRwNWZ5THdIUHRkaHZJNW5ScTJLSTJI?=
 =?utf-8?B?ZkdCb21rdVgxVThNMzZPOFIvV1MrMFQwWDIwZlhCZFIvcjZSajE5c3d2VHdj?=
 =?utf-8?B?MnQvbG5XSXVEbmFiWnJKK2UwS1FsaEVSRFJaSnNpSFEvdkloR09jS29YY1Jo?=
 =?utf-8?B?S05SVlZyQXBVZ29LakhoemZDN3YrQkZWWitUQ205ajVOTFVMQjZQZ01sZFM4?=
 =?utf-8?B?dHYzZTlhenU5d2ozQ0dNWmpJWlpwQVYzRHZsSWp0UHpyaWMycWNyQVJGMzJj?=
 =?utf-8?B?RFVFRkY1ZnA3eXFLc3lYL3ZOYjRTNmJIVWErSUVySkN6eWs0NWludnlJd3J1?=
 =?utf-8?B?V0FZWXpHeStPa0QrbWlKZHJNZU9nQ2N3amV0YXF1ZmFyMTFEcWdOS0NTU0t1?=
 =?utf-8?B?RW8vcG5JOGE5RW44MDhkbTY2OGpyQ1pTVFhSL3BIcFlqbERiMnUwYnI1bHY4?=
 =?utf-8?B?UllPVFNzN0VwRlFlZFYzWkdwcjJBTnpZbVlDQm0vOURtRUo5aXNHTk5OT2or?=
 =?utf-8?B?akpOR2JyQTFzWVovWm1CZ1NDOEZ6bHZPT0dXK0MrKzYwME8vQzN1Nk5ZQ1VF?=
 =?utf-8?B?dHNFUm5zd2ROQUZ5ZmVhRGJ6Y09FSUREcXQ4WnBON1p6QU9FeU12QW1PMHpi?=
 =?utf-8?B?SUpHR0tOVHZpbnlaTElsYkc5LzZHaWtPb3dONDZlWVREWFk4RVhjMldNTmdh?=
 =?utf-8?B?VElpbDUydWt1cnVJRENwV0k3QnN1cCtZajR6dTZvRHBIbjdhTzZHNy9LVHNS?=
 =?utf-8?B?eUU0bGNQZGhXMEhJdjFqMHVLc2haaUxDL2NXOGFCNGFZemVMN1JMUzN6cEVq?=
 =?utf-8?B?bkVlaUtFSzlIdXNVWmpGbWE0blp3V0Q2cy8xNGNuWEdhdUkydzNFV2lIVjJr?=
 =?utf-8?B?M3lhUEx3QjhXdUdIQWtuN0lMWHluY0dkK0dxY0ZYR2c2TFVkTkZJYlNYSVk1?=
 =?utf-8?B?OEIwVXBib09wdXdWeWVINkFXRDRPdDI3bi9oeEI5d2NMTVNTNFkwNlJWVnA3?=
 =?utf-8?B?T2d1T1U4RzNISEZvc0E1eExlSmtSRFdVQmNiMUFSak9ubnJrV0Q2N2tnUFM1?=
 =?utf-8?B?MDlGTkpBSEMra3RCM3JmWFdzRC9DS0E1V0UvWE9PMkYrQTVLRy81SktEcVc3?=
 =?utf-8?B?dEZkei9ScnhORVVrbkRvWnVxMHRXOEhsOEFTdkZEWlZyMSs3OVd4bjRSbHAv?=
 =?utf-8?B?VWRuNFJyWi9YZzZpQmlCMmhmWUdvODczTGUwWEorZmFrR2lRS2VnUFl3Q2Vy?=
 =?utf-8?B?OE44dTcwM0RQbHdrVHVEN3lJV005QVpQUGhPNjZWVE96a1RwWms1b2pnVDcv?=
 =?utf-8?B?clRKc3lSM0lFUEhiSm91enRiRmlDR3FvSmRJZk5Ub2pCdm9rTC9rc1U4WTBV?=
 =?utf-8?B?TU9GQXpLSXo5RDdoaTJyY1QwbkZRZkRKT0xZQ29uUngzYTVLSlpld1ZOakhV?=
 =?utf-8?B?aUNyc3NzNEY1Q282YUkvV24zQjBQdldpd3FCTm1QM1RWaWVFRElySXcvVS95?=
 =?utf-8?B?QUtNcGFFMFJmODlJZG5HZythanMrS2hqeFhRVWQrK0dtOU45WnFtVkZLSk54?=
 =?utf-8?B?SXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2DBF71FE00473A43A9962E1D64D7A55A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aWt1RGV0YTlCb3haWkViV0tRcmIrM3NCSzcvWUVOZ2crbzJJak9XUm1VSFJF?=
 =?utf-8?B?L1VWOVE5T0VMRWNYc0t5SHJJOXZaYmFwdXdhekNRVnBTRXo0UkxXdDRwRDRq?=
 =?utf-8?B?cGNSNkJncTVucUFUMHhrVEZVc3ZUZS9qOWtFeE5HSUkvYzg2WGJQRExYd3dz?=
 =?utf-8?B?UWNDSlo5NURqRFlGU2liTUtEZlhHTUJmZkoxdHpmeWZjMUZvamNveDNMUnFB?=
 =?utf-8?B?MEQzQUdxcnhWT2tPWDFwVXZJSE15ZG9waXB3L2k2M3hDRnR3RUw5ak56UkRP?=
 =?utf-8?B?cHI5a2hMTTBBT3ZCUGVpeldtdUh6K3NnMjZqT3hyUVdFZ3lDQTVQVmdFelpP?=
 =?utf-8?B?QXp5T0twTENKNVh3ZVNXb295QTZrbkkyeWRMQ1lLRkdNQVRsVWN5eDd4c090?=
 =?utf-8?B?V0ZjNS9UTzNIUlhJT09ielBxK0ttZ2xVbmtXdVFYTlM1YUZOV3JJWGdFQmxC?=
 =?utf-8?B?S2lFb3pITCtWaElJVGdBS0p5OVdsSUM2NEtjd3M1Wlo2TE9NODFYWUtlajZ1?=
 =?utf-8?B?NkpFQXpnUUU2UTVvVFFIa0RiVlppLzhoZHJJckFMdkJGZXYzc2VJU1p5c2o1?=
 =?utf-8?B?ZGQ1czRHeEFGckRVQ0Q2Z1pzMzh6WjlRYURQSHM2VThxVkVvMUJrY1phbkg4?=
 =?utf-8?B?MExrZHRiNTQzUjlWdTkwdTRYZ2F2bFRnVTBzby9VNnpuZzEzNHdjWDRsaks1?=
 =?utf-8?B?ZHhXZk5NZ3Axd3NwT013UGFkc3pFYTFWUXUwdGVYWm9qWnVLTGJzNDNjU2FV?=
 =?utf-8?B?MWVOSzVUcWNSMEJrWGZldXlEdGRpdVhCS2tMVUNFZnR6OG1NSE1UdWNrSStG?=
 =?utf-8?B?cEFWVzNNc25GbmJOcHEyL2tEV3dlNnAyRC9DQVZEZXo0YjlteWx6THlpTVFX?=
 =?utf-8?B?dU00RlFuMlI4dEpCK1JKeWRHL2hlYys1UDR5dHNMMzhRWVM5NGhTSlFDVzlx?=
 =?utf-8?B?TERocnB2ZUNLRUh0VXlVWVFDUmhjSjBMSFN2bStOZm1kaGxwNVNiOTNjdW52?=
 =?utf-8?B?bjJSdUtLdWg4VHlaL1k3bGdsZkN1VkJDZzlKMWtrcEdQbWxiY2QwVjF2NERF?=
 =?utf-8?B?STRWajlTeU52a09zZ285T3VlT0pDMHRWRW5Dak0vdnpVNzBuUVB1bWpLNG44?=
 =?utf-8?B?SEl5TzZxZVp2ZE1pb1gxaS95SWtVamV0SzIvUG5CanZxOTFBYmNHR2ZHMUVM?=
 =?utf-8?B?R1g2RC9KQVZVT2dIQk5Qd085ODlSc0t0Mk1UdkpGajQzYU43NnlmNTR1T0hQ?=
 =?utf-8?B?VWYwNFVTa2pWQ00rQnp1Y1pmZUdUdlM3UDYyQm5CcUg5czdFdz09?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c393ad99-e4a5-4d75-3104-08db2c969fd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 18:36:04.0894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X+7O7vM400yuD9wjn9zJ0DVdgDTsKXaxLdMZf3wqRR/kUk1S5M9nmiGLfzQOzlFU3xZN6Gu5qjrBtRVK8rSh0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6964
X-Proofpoint-GUID: 1MQTxY1luBGZrVx7wrTidEExWqZMjlq6
X-Proofpoint-ORIG-GUID: 1MQTxY1luBGZrVx7wrTidEExWqZMjlq6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 mlxscore=0
 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0 mlxlogscore=993
 malwarescore=0 impostorscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303240146
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBNYXIgMjQsIDIwMjMsIFJvZ2VyIFF1YWRyb3Mgd3JvdGU6DQo+IEV4cGxpY2l0bHkg
c2V0IGFuZCBjbGVhciB3YWtldXAgY29uZmlnIHNvIHdlIGRvbid0IGxlYXZlIGFueXRoaW5nDQo+
IHRvIGNoYW5jZS4NCj4gDQo+IENsZWFyIHdha2V1cCBzdGF0dXMgb24gc3VzcGVuZCBzbyB3ZSBr
bm93IHdoYXQgY2F1c2VkIHdha2UgdXAuDQo+IA0KPiBUaGUgTElORVNUQVRFIHdha2UgdXAgc2hv
dWxkIG5vdCBiZSBlbmFibGVkIGluIGRldmljZSBtb2RlDQo+IGlmIHdlIGFyZSBub3QgY29ubmVj
dGVkIHRvIGEgVVNCIGhvc3QgYW5kIGluIFVTQiBzdXNwZW5kIChVMi9MMykNCj4gZWxzZSBpdCB3
aWxsIGNhdXNlIHNwdXJpb3VzIHdha2UgdXAuDQo+IA0KPiBGb3Igbm93LCBkb24ndCBlbmFibGUg
TElORVNUQVRFLiBUaGlzIG1lYW5zIHdha2UgdXAgZnJvbQ0KPiBVU0IgcmVzdW1lIHdpbGwgbm90
IHdvcmsgYnV0IGF0IGxlYXN0IHdlIHdvbid0IGhhdmUgYW55IHNwdXJpb3VzDQo+IHdha2UgdXBz
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUm9nZXIgUXVhZHJvcyA8cm9nZXJxQGtlcm5lbC5vcmc+
DQo+IC0tLQ0KPiBDaGFuZ2Vsb2c6DQo+IHYyOiBkb24ndCBlbmFibGUgTElORVNUQVRFIHdha2Ut
dXAgYXQgYWxsIGluIGRldmljZSBtb2RlLg0KPiANCj4gIGRyaXZlcnMvdXNiL2R3YzMvZHdjMy1h
bTYyLmMgfCAyOCArKysrKysrKysrKysrKysrKystLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMTggaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy91c2IvZHdjMy9kd2MzLWFtNjIuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1hbTYy
LmMNCj4gaW5kZXggODU5YjQ4Mjc5NjU4Li5iMjJmYjc4YmM4ZTcgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvdXNiL2R3YzMvZHdjMy1hbTYyLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9kd2Mz
LWFtNjIuYw0KPiBAQCAtNjAsNiArNjAsMTMgQEANCj4gICNkZWZpbmUgVVNCU1NfV0FLRVVQX0NG
R19TRVNTVkFMSURfRU4JQklUKDEpDQo+ICAjZGVmaW5lIFVTQlNTX1dBS0VVUF9DRkdfVkJVU1ZB
TElEX0VOCUJJVCgwKQ0KPiAgDQo+ICsjZGVmaW5lIFVTQlNTX1dBS0VVUF9DRkdfQUxMCShVU0JT
U19XQUtFVVBfQ0ZHX1ZCVVNWQUxJRF9FTiB8IFwNCj4gKwkJCQkgVVNCU1NfV0FLRVVQX0NGR19T
RVNTVkFMSURfRU4gfCBcDQo+ICsJCQkJIFVTQlNTX1dBS0VVUF9DRkdfTElORVNUQVRFX0VOIHwg
XA0KPiArCQkJCSBVU0JTU19XQUtFVVBfQ0ZHX09WRVJDVVJSRU5UX0VOKQ0KPiArDQo+ICsjZGVm
aW5lIFVTQlNTX1dBS0VVUF9DRkdfTk9ORQkwDQo+ICsNCj4gIC8qIFdBS0VVUCBTVEFUIHJlZ2lz
dGVyIGJpdHMgKi8NCj4gICNkZWZpbmUgVVNCU1NfV0FLRVVQX1NUQVRfT1ZFUkNVUlJFTlQJQklU
KDQpDQo+ICAjZGVmaW5lIFVTQlNTX1dBS0VVUF9TVEFUX0xJTkVTVEFURQlCSVQoMykNCj4gQEAg
LTEwMyw2ICsxMTAsNyBAQCBzdHJ1Y3QgZHdjM19kYXRhIHsNCj4gIAlzdHJ1Y3QgcmVnbWFwICpz
eXNjb247DQo+ICAJdW5zaWduZWQgaW50IG9mZnNldDsNCj4gIAl1bnNpZ25lZCBpbnQgdmJ1c19k
aXZpZGVyOw0KPiArCXUzMiB3YWtldXBfc3RhdDsNCj4gIH07DQo+ICANCj4gIHN0YXRpYyBjb25z
dCBpbnQgZHdjM190aV9yYXRlX3RhYmxlW10gPSB7CS8qIGluIEtIWiAqLw0KPiBAQCAtMzAyLDEy
ICszMTAsMTcgQEAgc3RhdGljIGludCBkd2MzX3RpX3N1c3BlbmRfY29tbW9uKHN0cnVjdCBkZXZp
Y2UgKmRldikNCj4gIAkJLyogU2V0IHdha2V1cCBjb25maWcgZW5hYmxlIGJpdHMgKi8NCj4gIAkJ
cmVnID0gZHdjM190aV9yZWFkbChkYXRhLCBVU0JTU19XQUtFVVBfQ09ORklHKTsNCj4gIAkJaWYg
KGN1cnJlbnRfcHJ0Y2FwX2RpciA9PSBEV0MzX0dDVExfUFJUQ0FQX0hPU1QpIHsNCj4gLQkJCXJl
ZyB8PSBVU0JTU19XQUtFVVBfQ0ZHX0xJTkVTVEFURV9FTiB8IFVTQlNTX1dBS0VVUF9DRkdfT1ZF
UkNVUlJFTlRfRU47DQo+ICsJCQlyZWcgPSBVU0JTU19XQUtFVVBfQ0ZHX0xJTkVTVEFURV9FTiB8
IFVTQlNTX1dBS0VVUF9DRkdfT1ZFUkNVUlJFTlRfRU47DQo+ICAJCX0gZWxzZSB7DQo+IC0JCQly
ZWcgfD0gVVNCU1NfV0FLRVVQX0NGR19PVkVSQ1VSUkVOVF9FTiB8IFVTQlNTX1dBS0VVUF9DRkdf
TElORVNUQVRFX0VOIHwNCj4gLQkJCSAgICAgICBVU0JTU19XQUtFVVBfQ0ZHX1ZCVVNWQUxJRF9F
TjsNCj4gKwkJCXJlZyA9IFVTQlNTX1dBS0VVUF9DRkdfVkJVU1ZBTElEX0VOIHwgVVNCU1NfV0FL
RVVQX0NGR19TRVNTVkFMSURfRU47DQo+ICsJCQkvKg0KPiArCQkJICogRW5hYmxlIExJTkVTVEFU
RSB3YWtlIHVwIG9ubHkgaWYgY29ubmVjdGVkIHRvIGJ1cw0KPiArCQkJICogYW5kIGluIFUyL0wz
IHN0YXRlIGVsc2UgaXQgY2F1c2VzIHNwdXJpb3VzIHdha2UtdXAuDQo+ICsJCQkgKi8NCj4gIAkJ
fQ0KPiAgCQlkd2MzX3RpX3dyaXRlbChkYXRhLCBVU0JTU19XQUtFVVBfQ09ORklHLCByZWcpOw0K
PiArCQkvKiBjbGVhciB3YWtldXAgc3RhdHVzIHNvIHdlIGtub3cgd2hhdCBjYXVzZWQgdGhlIHdh
a2UgdXAgKi8NCj4gKwkJZHdjM190aV93cml0ZWwoZGF0YSwgVVNCU1NfV0FLRVVQX1NUQVQsIFVT
QlNTX1dBS0VVUF9TVEFUX0NMUik7DQo+ICAJfQ0KPiAgDQo+ICAJY2xrX2Rpc2FibGVfdW5wcmVw
YXJlKGRhdGEtPnVzYjJfcmVmY2xrKTsNCj4gQEAgLTMyNCwxNiArMzM3LDExIEBAIHN0YXRpYyBp
bnQgZHdjM190aV9yZXN1bWVfY29tbW9uKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIA0KPiAgCWlm
IChkZXZpY2VfbWF5X3dha2V1cChkZXYpKSB7DQo+ICAJCS8qIENsZWFyIHdha2V1cCBjb25maWcg
ZW5hYmxlIGJpdHMgKi8NCj4gLQkJcmVnID0gZHdjM190aV9yZWFkbChkYXRhLCBVU0JTU19XQUtF
VVBfQ09ORklHKTsNCj4gLQkJcmVnICY9IH4oVVNCU1NfV0FLRVVQX0NGR19PVkVSQ1VSUkVOVF9F
TiB8IFVTQlNTX1dBS0VVUF9DRkdfTElORVNUQVRFX0VOIHwNCj4gLQkJCSBVU0JTU19XQUtFVVBf
Q0ZHX1ZCVVNWQUxJRF9FTik7DQo+IC0JCWR3YzNfdGlfd3JpdGVsKGRhdGEsIFVTQlNTX1dBS0VV
UF9DT05GSUcsIHJlZyk7DQo+ICsJCWR3YzNfdGlfd3JpdGVsKGRhdGEsIFVTQlNTX1dBS0VVUF9D
T05GSUcsIFVTQlNTX1dBS0VVUF9DRkdfTk9ORSk7DQo+ICAJfQ0KPiAgDQo+ICAJcmVnID0gZHdj
M190aV9yZWFkbChkYXRhLCBVU0JTU19XQUtFVVBfU1RBVCk7DQo+IC0JLyogQ2xlYXIgdGhlIHdh
a2V1cCBzdGF0dXMgd2l0aCB3YWtldXAgY2xlYXIgYml0ICovDQo+IC0JcmVnIHw9IFVTQlNTX1dB
S0VVUF9TVEFUX0NMUjsNCj4gLQlkd2MzX3RpX3dyaXRlbChkYXRhLCBVU0JTU19XQUtFVVBfU1RB
VCwgcmVnKTsNCj4gKwlkYXRhLT53YWtldXBfc3RhdCA9IHJlZzsNCj4gIA0KPiAgCXJldHVybiAw
Ow0KPiAgfQ0KPiAtLSANCj4gMi4zNC4xDQo+IA0KDQpBY2tlZC1ieTogVGhpbmggTmd1eWVuIDxU
aGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpUaGFua3MsDQpUaGluaA==
