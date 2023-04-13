Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD53C6E0B37
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 12:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjDMKPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 06:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjDMKOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:14:50 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4309027;
        Thu, 13 Apr 2023 03:14:43 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33D8kEpC025449;
        Thu, 13 Apr 2023 03:14:20 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3px6byu5mt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Apr 2023 03:14:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nl12gCrGyZPMl7vde4Fyx3NGUL13jlrzfmZ4GCKW0eWoxKi40OmxhXHRQn68idJeqKH54u/4hBPkcfGW7jfxhNvG6wt4+6Pd5msd6V3KJBG8dQtVuiYvv8vdhbx/koSdnUtxWEEnEgUjP7mzT4//+kyZD01BTBT/yJ5C4LRIhd3dVvbHqR6XhV49xyvsCaIe/J/Uj+HOB666JwD5wUhFsOcBW3MQCyKJfJC8d62q3/DRx0CmAuzUoMFc0xUbtC/i5zhfQimPb0wrLmfOmjk+xkk0o/zUsuTbeA/1U2xnIOTmUh5H9yOHLfrHyCY/VQNdRyIQB1PT4tvyl0aRqo5Haw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRhseM5+Pbgtf9b6UDYenl9OAG020BHduMLZlmJVS8E=;
 b=CxdA0gm4n9N2AcmgeagD7IMtUvFj2EKFlv1YzuQ7ykWfTebD8W5kujzaTtnOAPqiTUaevdMqWhMZLG87oqBj3IHypwQoABv8ATZC6bwy/MM5NTNbiALFI3t0DDLpfe8Ria8QZwpomLuG00ZJzWufRkPuJIPz3VbjKVa7uJ4CTUV0Xe1vcUwS1csm7gLcYzAciImzYT1ajEdIH2qutpAKEmdNxyBSj/Hu7qtjGWxu+m0T7S6rOKuO3cf78JD/v+GDkfoSq2HCp4gixdDu5/HRni9CEYWf/dy1/jJ61QhndGWI9aJJ6pEycUU0L9RnXA13c0a894QDaUIFYp/y37c+0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRhseM5+Pbgtf9b6UDYenl9OAG020BHduMLZlmJVS8E=;
 b=YyoNzDt3Lz3XBRH2Ot5Pl+/9IJB52rBS1HEFDPfdLrpsVsoaNiqNa+cNHkoUSnQrwbn2zG6HoLk9421ERz/R6NF+wncxLL7QPdkf5JM5XTA8ohf6CDCUaFojh7uq1/Qg8kwLB9qkI1k6K4UhmAYWs+p/3rKw5gzD4NGHdWJMGm8=
Received: from DM5PR1801MB1883.namprd18.prod.outlook.com (2603:10b6:4:62::23)
 by CY4PR18MB1365.namprd18.prod.outlook.com (2603:10b6:903:14b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 10:14:16 +0000
Received: from DM5PR1801MB1883.namprd18.prod.outlook.com
 ([fe80::539a:cb03:47cd:9551]) by DM5PR1801MB1883.namprd18.prod.outlook.com
 ([fe80::539a:cb03:47cd:9551%5]) with mapi id 15.20.6254.033; Thu, 13 Apr 2023
 10:14:16 +0000
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     Rob Herring <robh@kernel.org>
CC:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH 1/2] dt-bindings: watchdog: marvell octeonTX2
 GTI watchdog driver
Thread-Topic: [EXT] Re: [PATCH 1/2] dt-bindings: watchdog: marvell octeonTX2
 GTI watchdog driver
Thread-Index: AQHZXmDkfAWgBGXsV0m/z0wcr14rMq8KY1iAgB6/uNA=
Date:   Thu, 13 Apr 2023 10:14:16 +0000
Message-ID: <DM5PR1801MB188382274130294816B70704E3989@DM5PR1801MB1883.namprd18.prod.outlook.com>
References: <20230324145652.19221-1-bbhushan2@marvell.com>
 <20230324203437.GA2439497-robh@kernel.org>
In-Reply-To: <20230324203437.GA2439497-robh@kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYmJodXNoYW4y?=
 =?us-ascii?Q?XGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0?=
 =?us-ascii?Q?YmEyOWUzNWJcbXNnc1xtc2ctZWYzNjMxOTAtZDllMy0xMWVkLWFlNzktMDRi?=
 =?us-ascii?Q?OWUzMzM4ZjZlXGFtZS10ZXN0XGVmMzYzMTkxLWQ5ZTMtMTFlZC1hZTc5LTA0?=
 =?us-ascii?Q?YjllMzMzOGY2ZWJvZHkudHh0IiBzej0iMzU5MyIgdD0iMTMzMjU4NTQ0NTI2?=
 =?us-ascii?Q?OTYyNzY2IiBoPSJmb2cvRnMyNnhBSGw4K1R6dmp1TUU1eVB0b3c9IiBpZD0i?=
 =?us-ascii?Q?IiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFIWUlB?=
 =?us-ascii?Q?QUJPc05DeDhHM1pBZnFxWHdEN0hNNC8rcXBmQVBzY3pqOE5BQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBSEFBQUFBR0NBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBUUFCQUFBQTFGSDNhQUFBQUFBQUFBQUFBQUFBQUo0QUFBQmhBR1FB?=
 =?us-ascii?Q?WkFCeUFHVUFjd0J6QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdNQWRRQnpBSFFBYndCdEFGOEFj?=
 =?us-ascii?Q?QUJsQUhJQWN3QnZBRzRBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNB?=
 =?us-ascii?Q?QUFBQUFDZUFBQUFZd0IxQUhNQWRBQnZBRzBBWHdCd0FHZ0Fid0J1QUdVQWJn?=
 =?us-ascii?Q?QjFBRzBBWWdCbEFISUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCakFI?=
 =?us-ascii?Q?VUFjd0IwQUc4QWJRQmZBSE1BY3dCdUFGOEFaQUJoQUhNQWFBQmZBSFlBTUFB?=
 =?us-ascii?Q?eUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refone: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFB?=
 =?us-ascii?Q?R01BZFFCekFIUUFid0J0QUY4QWN3QnpBRzRBWHdCckFHVUFlUUIzQUc4QWNn?=
 =?us-ascii?Q?QmtBSE1BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVl3QjFBSE1BZEFCdkFH?=
 =?us-ascii?Q?MEFYd0J6QUhNQWJnQmZBRzRBYndCa0FHVUFiQUJwQUcwQWFRQjBBR1VBY2dC?=
 =?us-ascii?Q?ZkFIWUFNQUF5QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFB?=
 =?us-ascii?Q?QUFBQUlBQUFBQUFKNEFBQUJqQUhVQWN3QjBBRzhBYlFCZkFITUFjd0J1QUY4?=
 =?us-ascii?Q?QWN3QndBR0VBWXdCbEFGOEFkZ0F3QURJQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdB?=
 =?us-ascii?Q?QUFHUUFiQUJ3QUY4QWN3QnJBSGtBY0FCbEFGOEFZd0JvQUdFQWRBQmZBRzBB?=
 =?us-ascii?Q?WlFCekFITUFZUUJuQUdVQVh3QjJBREFBTWdBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBWkFCc0FIQUFYd0J6?=
 =?us-ascii?Q?QUd3QVlRQmpBR3NBWHdCakFHZ0FZUUIwQUY4QWJRQmxBSE1BY3dCaEFHY0Fa?=
 =?us-ascii?Q?UUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQmtBR3dBY0FC?=
 =?us-ascii?Q?ZkFIUUFaUUJoQUcwQWN3QmZBRzhBYmdCbEFHUUFjZ0JwQUhZQVpRQmZBR1lB?=
 =?us-ascii?Q?YVFCc0FHVUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdVQWJRQmhBR2tBYkFCZkFHRUFaQUJr?=
 =?us-ascii?Q?QUhJQVpRQnpBSE1BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUNnQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFIQUFjZ0J2QUdvQVpRQmpB?=
 =?us-ascii?Q?SFFBWHdCakFHOEFaQUJsQUhNQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCdEFHRUFj?=
 =?us-ascii?Q?Z0IyQUdVQWJBQnNBRjhBZEFCbEFISUFiUUJwQUc0QWRRQnpBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQSIvPjwvbWV0YT4=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR1801MB1883:EE_|CY4PR18MB1365:EE_
x-ms-office365-filtering-correlation-id: 1b974393-0844-432a-2127-08db3c07d653
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8KeqlHx7+FIh/9/SR0vj5Xgom7mSv/O7th9aY4Tr+ovmbXku6lOG3CFfappnnKgzhhaQMoB3lE+113hYKGC9C2kRo8DpKhPUvJ1RZWrgAhK33wWldkzbcakxRk0vO8Llzb/lnN66cYOmjmA0vKxpogcoyUOgh5DTHk9D1bZ0KES/6wuC091XSJ1MOmhS+f69190cefUWUfUFNQzmtwjo0c+2NEsiL/Ye+X1t8n/XWWghzrQ1AoNAukr3YdWK+z506ogxrjQtIbNZJPym+945CWy5oeRv0ULXGpiwTECb9L+DUq6gDAgZP7lmwvPNZUn6m8cneQer/ls8fDl7TwcDpbkpftOnlkW+zSHBdFCyJgjpyliS9uqR2Nzx+iuxIo2OBV9w9SbDF0GUOYHsFvC5KzjkzUT3ybIFq6DeFVxfAbueykk15n5nvbLc2qT2GqsM0fluggq+xvPCyjJrYnpKgz9kNZMkQfk+kdruXcG/vdgR1otQmDaQ5UBVUpO3wWpKuyJnXXTtAbdRXGvsj0ArQNr8enpExZDs4qF170NAA9LC1xgWCmJkwFLoEOqpebsRwkkLnyQt8HBqxUiUvirOQaGoQIw6N+K09QSi+PjqBSVhJtttG9ZKJB0+n6e+C/LzWLrU3hL9QuwAouq6m+FIQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1801MB1883.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(451199021)(2906002)(38070700005)(86362001)(41300700001)(76116006)(8676002)(8936002)(71200400001)(4326008)(64756008)(66556008)(66446008)(66476007)(6916009)(66946007)(5660300002)(52536014)(54906003)(38100700002)(316002)(122000001)(19627235002)(478600001)(83380400001)(33656002)(7696005)(55016003)(186003)(55236004)(6506007)(9686003)(53546011)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Sv7LEeyCPA8eh/hrTR5Xt57YHkzlgcvxMDDjZ4+LsAR9qnaM/6TAw/QX9xzk?=
 =?us-ascii?Q?gkuUChv8X/lx1iRl5ISPEWYB4fUtFIAWVn95cajnxUOf+aDcaUcvITj7xHER?=
 =?us-ascii?Q?zRscMeo5gH9tR2sAf5KXeZenEYkoVpZsQnIAn23TWAGzq5/kV7HeY0lLUFVd?=
 =?us-ascii?Q?KKJ2Ae3uTA9zLy8GdNm3+19QL1o3UUj1J87rUpTEWP2W6ClBOzdX6s/PLk3y?=
 =?us-ascii?Q?AbMnjc2nAGpf8NV4ES73Atcrn2vI9icglmDi5HNacQav4odMXlgYZDNPtJ5f?=
 =?us-ascii?Q?8o0ByTgCBwGAtx20kk35XemLozRMVFR4Q5US5aLh2y7P1AlcMedYytuBgbSE?=
 =?us-ascii?Q?sMHGhChJtKPlt+p1K8/WBROQtDyhGSz4HWcQR7hIqvtVX4kZTl/UwJuWDqWP?=
 =?us-ascii?Q?FjeNEvKCEvIBGTeotUZeW1PTh6UDxZ59jYPgw65N4R2DKj1lIWVYkD7U48xv?=
 =?us-ascii?Q?f2KvrJn392A5CXgayPmjC6mLkNf0gTMhF6Cr73LMZWaqn6Yw0PildJ6t8XOt?=
 =?us-ascii?Q?zpqUHKU5jvafAQlGWxAm7ex8eh184isL43gwCPrfm8Pb/mAie8iOIn0PVP1r?=
 =?us-ascii?Q?njxU/fXOmD1wRumfrk1aptu1BsyfKJZ4xrSe6bGCMi8ZhKHJl62cG+NC3moG?=
 =?us-ascii?Q?V/tz88j6KbmskQiOEFuht30xRJQvTNjk34X/Sv2JGzsucQeyGru2waEN53te?=
 =?us-ascii?Q?hbhZW8rgXS54YDciY8ZbklXoCSFQ0uULIOrbT4y38Ne4OGTBW7tSWebT4XVo?=
 =?us-ascii?Q?2Ar948moqgiWYq3N/NTlWJrcfI7wYvMGwzu3jw6uiVoyTHdEpptRIwiraJWG?=
 =?us-ascii?Q?hqELdhYqyuxCSzTrhW8DT1D8mJHz7GiAiI0BbwljilOv5M1o6h10aHzChH0K?=
 =?us-ascii?Q?1cmnVuCu+qPCQTv3haByGKqUJtjEzR07xOSy8xNWGVTYaOOhfz5x733BvIJH?=
 =?us-ascii?Q?aB6rLnlwn65SRk7ez16gHP2J/mu6cr87rvtNrY6ijMJVEh1Oogv+RWQDnqoX?=
 =?us-ascii?Q?DUF9ouMkea9xIap8uYjOe4YyITdqHn+ok8oRnjf03nw36wI2VGbMjXc7Sr2F?=
 =?us-ascii?Q?504nC1vfWWgGgeSlmJs/JCsvo0EmPmr1/EYlnhWnAMOgzL0DyirwUzsU8Op/?=
 =?us-ascii?Q?WLUGJYQ5HW4oGCyvHkWDFQzNwIYoMqhh/NuKncxewuCftAKxBl8O6hCz+C6p?=
 =?us-ascii?Q?0/HXzicanwHrT0cg+YqzplCNrIiIC2zfyAorW2AaS77nOqvpvyIwDx8ewj9H?=
 =?us-ascii?Q?u00MThsrCJco2e97n5OpXNFuP3guwmg8mbc1tThifHTYXkzPwRfMNDJdG1PD?=
 =?us-ascii?Q?4OPrkypnF/Dt64UXB5+nZvN+b0MQCBXBzGDTr3KDj4WezvaPqYGF4/DaTB3r?=
 =?us-ascii?Q?46iCrimB93992G50Z/jqpeKDc244RVGMWHQMZGjecf5zfC/oXkZvxHzsjVpt?=
 =?us-ascii?Q?EvNrNxMBi0zzxKUMkaynJBxW2mHIdZB/IZc/5a0QX998ruhdc/BtFk0jvay8?=
 =?us-ascii?Q?DpjkP/9mOO/WWed+g6LZ80pEawvqLEaLmzWnsslOOldjh2hD6UconxSm8xws?=
 =?us-ascii?Q?vUyPjOFWuhH7j0DDzPMBPxp8PPMX7xMzIEJ1SlPY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1801MB1883.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b974393-0844-432a-2127-08db3c07d653
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2023 10:14:16.0803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vm6tZquyXW+PWBsYsFSzNdshK2Ph4iflj2jVK11gzbSUs7cb2UQnhBOvFktROQhs5XkZElUOOuCbMizp46UJFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR18MB1365
X-Proofpoint-GUID: 7Z31y_3Wzov_QTRmiFSQbDtn0eFEFCTM
X-Proofpoint-ORIG-GUID: 7Z31y_3Wzov_QTRmiFSQbDtn0eFEFCTM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-13_06,2023-04-13_01,2023-02-09_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please see inline

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Saturday, March 25, 2023 2:05 AM
> To: Bharat Bhushan <bbhushan2@marvell.com>
> Cc: wim@linux-watchdog.org; linux@roeck-us.net;
> krzysztof.kozlowski+dt@linaro.org; linux-watchdog@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [EXT] Re: [PATCH 1/2] dt-bindings: watchdog: marvell octeonTX2 G=
TI
> watchdog driver
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On Fri, Mar 24, 2023 at 08:26:51PM +0530, Bharat Bhushan wrote:
> > Add binding documentation for the Marvell octeonTX2 GTI watchdog
> > driver.
> >
> > Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> > ---
> >  .../watchdog/marvel-octeontx2-wdt.yaml        | 43 +++++++++++++++++++
>=20
> The comics?
>=20
> Use compatible string for filename.

Sorry for late reply, just returned from vacation. Thanks for review.

Will fix all these issues. Also run "make dt_binding_check".

Thanks
-Bharat

>=20
> >  1 file changed, 43 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/watchdog/marvel-octeontx2-wdt.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/watchdog/marvel-octeontx2-wdt.yaml
> > b/Documentation/devicetree/bindings/watchdog/marvel-octeontx2-wdt.yaml
> > new file mode 100644
> > index 000000000000..586b3c1bd780
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/watchdog/marvel-octeontx2-wdt.
> > +++ yaml
> > @@ -0,0 +1,43 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> > +https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__devicetree.org_s=
c
> > +hemas_watchdog_marvel-2Docteontx2-2Dwdt.yaml-
> 23&d=3DDwIBAg&c=3DnKjWec2b6R
> >
> +0mOyPaz7xtfQ&r=3DPAAlWswPe7d8gHlGbCLmy2YezyK7O3Hv_t2heGnouBw&m=3D
> Ut_moFc_
> >
> +jI4JG2ZlRAaLIL9HLPOI2Thz6WmALCu5SENmtKrGa0M4tN0m5TP0eBw5&s=3DJ3P7a
> QnYY3
> > +pKqoGp1-eiSsINlof1pAh3u-aLn4tfrLk&e=3D
> > +$schema:
> > +https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__devicetree.org_m=
e
> > +ta-2Dschemas_core.yaml-
> 23&d=3DDwIBAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DPAAlWsw
> >
> +Pe7d8gHlGbCLmy2YezyK7O3Hv_t2heGnouBw&m=3DUt_moFc_jI4JG2ZlRAaLIL9HL
> POI2T
> >
> +hz6WmALCu5SENmtKrGa0M4tN0m5TP0eBw5&s=3DGdtkUc3_hrJV0gvS1Eviv1mxf
> KMLIv7Y
> > +IohR76Dtkmc&e=3D
> > +
> > +title: Marvell OcteonTX2 GTI watchdog
> > +
> > +allOf:
> > +  - $ref: "watchdog.yaml#"
>=20
> Drop quotes
>=20
> > +
> > +maintainers:
> > +  - Bharat Bhushan <bbhushan2@marvell.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - mrvl,octeontx2-gti-wdt
>=20
> 'mrvl' is deprecated. Use 'marvell'
>=20
> > +
> > +  reg:
> > +    maxItems: 2
>=20
> Need to define what each entry is.
>=20
> > +
> > +  interrupts:
> > +    minItems: 1
> > +    maxItems: 36
>=20
> Need to define what each entry is. How does the h/w have a variable numbe=
r of
> interrupts?
>=20
> > +
> > +required:
> > + - compatible
> > + - reg
> > + - interrupts
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    watch-dog@802000040000 {
>=20
> watchdog@...
>=20
> > +      compatible =3D "mrvl,octeontx2-gti-wdt";
> > +      reg =3D <0x8020 0x40000 0x0 0x20000>;
> > +      interrupts =3D <0 38 1>, /* Core-0 */
> > +                   <0 39 1>; /* Core-1 */
> > +    };
> > +
> > +...
> > --
> > 2.17.1
> >
