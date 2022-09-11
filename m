Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250FC5B500D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 18:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiIKQhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 12:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiIKQha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 12:37:30 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2045.outbound.protection.outlook.com [104.47.51.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F65D9E;
        Sun, 11 Sep 2022 09:37:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mAcJWicjW2LDpMJf0169zVKKoTX3FiBFU05SiwwyYpOWROo07sSVcsK28WkGAnb0FKYAxXMc/RCfNa/Zs5+58qTLWssUDS0bFdRTWpu4l+BZp8ccFFSuupralwiySiR8Y9iYsFIkI348xy2V76DebwHJueI0uvpocwpFu4qd63J7Zx5pgqRXtZxKXVs+AZDmpYpCMfJ9pudi+S1BntDQFlvHnzYZZcuhLfRGHYOwb8r+6rjkeHGhg7RkINBQxd/5+9q9Q55TagULRwfCa59v9kIBnwnJB44jUPqGghJvoqXnj7qLcnbrYqrI6Xfhc/HtWUR+/JS+mJD616z8ju1LAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qhUPBNOhz+kD4sYIG7SR2X03YxLr3zTNkLZGiPSMW8=;
 b=iAYHmTFwQa/6OOqLVoiLjucK6vsm5DRxuzOjlJ6bXCCoQZdbE1lNNeiSiIrqtR3sQ7gbLlHGSW8GnPHxzvEkg1Jqhf0Hep2LA4E6D36me36wLMHH/rNnS+oHEi2JeNWn2MPAvOMMTcJu7WwK7xysqSwYuwBw+42HtuzopZ0dDwbSLs0e9eSQ7ucxvoV1zLMjvpzjSjgBLRkEJgOErWoZIBm5wC/CDhPMJhSDqvA+BOZ1ko21A/1WO764+YvOQYr+f1v4vIKs0CvpGSDIQu2VbvKbD4vrWnZKN2Z7XhfYjdwuLOtt4ukaA1+JhKdb60ll+rFPnde0DGK2tnleGYs7sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qhUPBNOhz+kD4sYIG7SR2X03YxLr3zTNkLZGiPSMW8=;
 b=rD1Yaz2HvsE2q2Rr0+69g1H/+7yQCdCvjzKSKvQXULCHtk98/8gs29yp2n7W7lhXfvzE8KtJF5pM3GpE1yx2LtRcAHaz7NcyKG0Rw/6ExExJq8IgdEbhOR9XQmd+5GK3UOC4s422mnoGt0+hVKwlyeeSI/NmIdDZxO7TlwdrSHQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by BLAPR10MB5331.namprd10.prod.outlook.com
 (2603:10b6:208:334::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Sun, 11 Sep
 2022 16:37:27 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::38ee:4bfb:c7b8:72e1]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::38ee:4bfb:c7b8:72e1%7]) with mapi id 15.20.5588.020; Sun, 11 Sep 2022
 16:37:27 +0000
From:   Colin Foster <colin.foster@in-advantage.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-mips@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        UNGLinuxDriver@microchip.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 0/1] Convert phy-ocelot-serdes documentation to YAML
Date:   Sun, 11 Sep 2022 09:37:14 -0700
Message-Id: <20220911163715.4036144-1-colin.foster@in-advantage.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0128.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::13) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e4fb3d9-8fae-4282-9098-08da9413e984
X-MS-TrafficTypeDiagnostic: BLAPR10MB5331:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6xBSRfYmy1+nyHrDOug/ujAq9EP/bm4hhRFTZrLP/KJu3q26mWIghoX5PxEN2SmGRNUwZ68faifz9KIUvG2Ij7MN1dwx6Kg0EqsMiUnRdN+Lv69Bt1zigcl4z47ksyqCAuIcTdrwWYWhOwMPMarzpLQWX7+NWoIM1RyIO2h9j9mVmFAxSEvDwoQZkd+LSwraj2CeGZD71fHWYqXCoKwDetQRK3qOBa6bMfNZCIuBUfkeNpctOGko4Igfd/I0+2M7kY59zZXyT/qPS5xxdGNKDAz5sDTIRxeopEJpy9/MR2oG/J6PYam0fyllTyUsEfu0eV39ypbtlokS8bmg4xkWJnZQ6b0KerRz4gj7+xVl2xbRA3yQUHMDDM2AAgUM0+zeT4o0asovc2Hywelv4HfM7oY7E7ZsyrdmhK3cOWAQOZeAbJdS23IzHQ5c+pM0wTW1JAJqEl1H2vFFWWKBA3C4Jc1YMPnYH5eO1wd4JT/0H48ODDRimcn7wmJTbhSuh/OUMte4Q/uZ/WxeAdZcaZZXmJ9EbUXngA/ibSg3HSlY49jBXCfXmRAiUxtdsV+S5p3DHSPdOKQIMJH39iKN48XWtELpXqDFsEiL/VDGAaCnmYxQgyBc+/llgJ1nLd7ttKy4MRgzZyCZQGggXZA516kJ2NmP/wUTP9sTEQ0AGyD5Qn45yubTbve+HB17/AQtx1YT7nmbQeoUEq5aC45GFflSABE2HaGdLPPb84el8IAxN8n5HeEEwxoPBsQu5/bB1TVS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39830400003)(396003)(366004)(376002)(346002)(136003)(66946007)(66556008)(4326008)(66476007)(8676002)(6486002)(41300700001)(316002)(54906003)(86362001)(478600001)(36756003)(8936002)(2906002)(44832011)(7416002)(5660300002)(4744005)(38100700002)(38350700002)(26005)(6666004)(6512007)(52116002)(83380400001)(186003)(6506007)(1076003)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mYly3KqfXLF9AKvAXwgPuHXI5qwbrbaUx1Pld9FuKFPJEQdAieaVK8Ua0HvG?=
 =?us-ascii?Q?GQJuRFbCz/xbYWG37ec5U1O9Xzcc5SqYnJAGn/6rouQh3ZAWQxOzVIpzrsnb?=
 =?us-ascii?Q?ZTw6DnFUwPKrN97ozwbS/EtWXMyvvBYEmV6fFTrSjkqLEleE7WCzcUXuGamb?=
 =?us-ascii?Q?AbSwuoRiAtnEc+6GFYNgDfCIQyducvCVQ9nEnnJdF+yDJjnzY3bVv+tCSBd5?=
 =?us-ascii?Q?Bt9exZ+2GKnTEU0Cprhsu8Igyd99d39eDgYwEDMIo7DktsITvkG/ALCb8uQr?=
 =?us-ascii?Q?DjVPzG4Wi0SjbFAbKnuBACJPnuljnSHCZKKij/jE4tyEK/H8vajEi1QUnbCi?=
 =?us-ascii?Q?VNc3rDO5BTMTDqqqfw/s0clZ0qrXTx5KJOAcI6yf8XpR8vh63oV3uBB6fMFd?=
 =?us-ascii?Q?Fey9DHKPodDZ/bACwhh4RtVS5fdrow5Wh7ZgHIrlUzwk4wMw54XYW6F6SWty?=
 =?us-ascii?Q?wdjJwCxQrzTHlCpzta4y9DD71rApQ9+aNPYQ91qmooXoUJQQC6arOkA6D++P?=
 =?us-ascii?Q?E1CfSyr7B0bjRT1RlLWmjbQ135pdtYWPRL5n6tRdJYwswL9noUXPEt1IV6QV?=
 =?us-ascii?Q?2L226suaimlMxhxuVH1Nyg7YpIzimP7xhPePUJREJ7pOxJOWkJQbdVDVH5NC?=
 =?us-ascii?Q?rquL8Y75be5So+9dwfRWnXZuDcf+iiwE58PaRn6BJ0BGosnYFXb/E+8sT07S?=
 =?us-ascii?Q?5yb1eDUePOqbqalbRksJ83JF+FJBHm0rZpX7U+BaE87y2PldGHmFobFkE45S?=
 =?us-ascii?Q?8dsC5h12UDlCSJmBs31PRv8DKVOBmiT/MdtC3PjCzCbMFlU87jMe+OE27pG5?=
 =?us-ascii?Q?ymyYt4pjkWeyxnFW3wtx+uWLZ3qr62Z0nsWcgO5ngl3mYItQ0yWXfGwUM3Vp?=
 =?us-ascii?Q?oHHybYGYmA+OdpZZlCwvLL0rX5ZchgAtSRkOpRNPajqbzRl7sXTfW7cOAMNz?=
 =?us-ascii?Q?hN//slVI7BRjgIJORjgsmNp5HHlA+G+KlucghnJvaUzGaKjFhIRrDBh5JhBn?=
 =?us-ascii?Q?cJA/+SN8r7V7y2nrDwaRoVECgLsnL5RtVzUSkif4RGQO+X+2G9KHnP/arlEQ?=
 =?us-ascii?Q?VnIXLF6TlW9AB8d5Jwrz3MjWjw+qHEzL/7/kFWynQ15mjsNecAlutqeuMGfI?=
 =?us-ascii?Q?acyjiPrnY/8FJhIWnwgkoAt8JEG/PQRR3a8hDwVU0sVqikfcZd9f0NwEhELJ?=
 =?us-ascii?Q?kUAFqvuaadMVHjaVk7zPR7UwJS49DgtNa75MTiC+o3cmOnI5BnNR7Xc4OUnB?=
 =?us-ascii?Q?uPWEbCJZ7jCOtdz+uY9vN2Mh3R+Kp9AL2Me7zwzJhLJKY+so+A55RF6CGVzt?=
 =?us-ascii?Q?+e3Y+NQ0bovIvZQ+bAHSehk8eC9KRrQKGYqfraiBgnMtSG9X3qqIZEK5ds3L?=
 =?us-ascii?Q?kv2h2BwtyT6pngFZ3M3IC+fDvDyTooWq+eDPagw1O+hwoq6+lDz2iITu0F/3?=
 =?us-ascii?Q?bpaL/wLqrnGrCoc1U3xIPK9oDSJIzL/nJr7vEXEYMPMy+CQhPlhPX+UsIIhr?=
 =?us-ascii?Q?bJpHPyL1jIJbO7sWw8qKx8L9FRW5VMtKiXxPzMWS5QIwSZyQBPN5JfIbx7xB?=
 =?us-ascii?Q?mVXxngPNjMTOc7t6sbDGz+te07CF1i5SWq38Wk8i2jO0uUSV9Gk7y54Fi71S?=
 =?us-ascii?Q?Kw=3D=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e4fb3d9-8fae-4282-9098-08da9413e984
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2022 16:37:27.2696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yVHE6K5tFK8hMLo/UtWv6AL9KsevT7hVFOSj44obDCg4oeCeqfpItEQCtZwDgOPusTNzqUmLmNZ0BwFhBedrNbN4lKNm5b0zeznJZR1BAvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5331
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Work is currently being done to add the phy-ocelot-serdes driver to a
non-syscon configuration. Doing so will require updates to the
documentation.

I can certainly wait until that change set to submit this, but I feel
sooner is better than later for Documentation format updates. Also,
those updates likely won't be ready before this next merge window.

The only liberty I took was adding Alexandre and UNGLinuxDriver as the
maintainers, otherwise the content should be the same.

v1 -> v2:
    * Implemented changes from Krzysztof - see patch for details

Colin Foster (1):
  dt-bindings: phy: ocelot-serdes: convert to YAML

 .../bindings/phy/mscc,vsc7514-serdes.yaml     | 56 +++++++++++++++++++
 .../bindings/phy/phy-ocelot-serdes.txt        | 43 --------------
 MAINTAINERS                                   |  1 +
 3 files changed, 57 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/mscc,vsc7514-serdes.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt

-- 
2.25.1

