Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D853170F5BD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 13:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjEXL5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 07:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjEXL5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 07:57:30 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03321130;
        Wed, 24 May 2023 04:57:29 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34O4qi5D025791;
        Wed, 24 May 2023 04:56:19 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3qsbxesecq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 04:56:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9wFQKZShmQ7qM2wCJQNNdixBqAOcUybl6KI0nhUC/km0pBeIv2qgP7/xHGSrvu4lkF3PA+ld27h+e3UpyQurxxBDjMmmzEc0dPO63/FCVwNu+USxHeC3AkunqyNlOyL28PA4kZqW4Yqu7BBY3qX/crTlSOmcUwm0PQkdX1dJWKwcLWB/W99bPHab8Tchxn75FdN8H6xdb4stutuJ/LhLNzVm/xv+yIA33Zk9AbY+6vFPL2IAPA8rhdMyqHibVhy+7WWVJX/kL2B+8WYcqWkmIGLX1BhwZV8l2z6iAt2VKazEIJul37eLzulmI8jBYz0NXZSbNYenbnZpLe5ScgG5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRY+5CERGvfAIr18/9ffi2OmrJ8c0eGrxe9SOxAYSxY=;
 b=YEuamUlO7QgebuCE+Qdp2DAnjvdMnn/O8jPtCBv/EJe5oe/8xdUoShsgk+T5Zj/LypIBscI1Z2vRrNVn5XES+ysMah7qETwjmTD5P59NfBS+Zy11yH7XNVn5JAOjsnHdlgDpb8uAhFTeAhj7Ie7C43G4B3jzofr3QGM4VZlosVLLi6w61uGFSD+ZuFgPiVhRiP+2LCoAU/X9n8BR6QIcaXMBuD+bfqgVzPe+Tn/+4cXgx7DHJ2l6jLe1k9TN+sksraPKy2nol+uT6SA3sArICQGgu3IQwtHLW65i0g61FGB9zaNOTozprFI/Vue4mO20m0TQ+mNdMUHCZji7b/WklQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRY+5CERGvfAIr18/9ffi2OmrJ8c0eGrxe9SOxAYSxY=;
 b=qjGA+Rzl1b97JhOuF4CGlrRTKOa1PUMgL5NoMmP0oIMnLTQ2/01Ft5BrKWj7K5sivJorIS0gegtaqoCUDW0BsH8g2FMEQp9QSAqMKYuuBvKBjSuDDgACBcrPEgAcpHj1wyWWapU/jslJi3CWuCcgL+qFuXTvvYQArewb4ZQzBxs=
Received: from DM5PR1801MB1883.namprd18.prod.outlook.com (2603:10b6:4:62::23)
 by SJ0PR18MB4961.namprd18.prod.outlook.com (2603:10b6:a03:3e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 11:56:17 +0000
Received: from DM5PR1801MB1883.namprd18.prod.outlook.com
 ([fe80::8728:7063:8550:fa8c]) by DM5PR1801MB1883.namprd18.prod.outlook.com
 ([fe80::8728:7063:8550:fa8c%4]) with mapi id 15.20.6411.021; Wed, 24 May 2023
 11:56:17 +0000
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     "olivia@selenic.com" <olivia@selenic.com>,
        "Jason@zx2c4.com" <Jason@zx2c4.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>
Subject: RE: [EXT] Re: [PATCH] hwrng: cn10k: Add extended trng register
 support
Thread-Topic: [EXT] Re: [PATCH] hwrng: cn10k: Add extended trng register
 support
Thread-Index: AQHZiVSmCmlVFfYdQUawDfQPgic/Oq9pOUAAgAATubA=
Date:   Wed, 24 May 2023 11:56:16 +0000
Message-ID: <DM5PR1801MB188333F8A818A5F887AC5440E3419@DM5PR1801MB1883.namprd18.prod.outlook.com>
References: <20230518064734.18819-1-bbhushan2@marvell.com>
 <ZG3fNmNfUHeWIsNZ@gondor.apana.org.au>
In-Reply-To: <ZG3fNmNfUHeWIsNZ@gondor.apana.org.au>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYmJodXNoYW4y?=
 =?us-ascii?Q?XGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0?=
 =?us-ascii?Q?YmEyOWUzNWJcbXNnc1xtc2ctZmEwZjlhMmQtZmEyOS0xMWVkLWFlN2UtNDgy?=
 =?us-ascii?Q?YWUzNzQwYjc2XGFtZS10ZXN0XGZhMGY5YTJlLWZhMjktMTFlZC1hZTdlLTQ4?=
 =?us-ascii?Q?MmFlMzc0MGI3NmJvZHkudHh0IiBzej0iMjk5NiIgdD0iMTMzMjk0MDI5NzI5?=
 =?us-ascii?Q?NjIwODI1IiBoPSJJLzQ3WUE5VHcwbVdjSUlLbDVxNmxid2huelE9IiBpZD0i?=
 =?us-ascii?Q?IiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFONFBB?=
 =?us-ascii?Q?QUJaNDdhOE5vN1pBYWJydlJHYlR2dlpwdXU5RVp0Tys5a1pBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBSEFBQUFCdUR3QUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBUUVCQUFBQUk3cVRwQUNBQVFBQUFBQUFBQUFBQUo0QUFBQmhBR1FB?=
 =?us-ascii?Q?WkFCeUFHVUFjd0J6QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdNQWRRQnpBSFFBYndCdEFGOEFj?=
 =?us-ascii?Q?QUJsQUhJQWN3QnZBRzRBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFnQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUJ3QUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFiUUJoQUhJQWRnQmxBR3dBWHdCd0FISUFid0JxQUdVQVl3QjBB?=
 =?us-ascii?Q?RjhBYmdCaEFHMEFaUUJ6QUY4QVl3QnZBRzRBWmdCcEFHUUFaUUJ1QUhRQWFR?=
 =?us-ascii?Q?QmhBR3dBWHdCaEFHd0Fid0J1QUdVQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCdEFHRUFj?=
 =?us-ascii?Q?Z0IyQUdVQWJBQmZBSEFBY2dCdkFHb0FaUUJqQUhRQVh3QnVBR0VBYlFCbEFI?=
 =?us-ascii?Q?TUFYd0J5QUdVQWN3QjBBSElBYVFCakFIUUFaUUJrQUY4QVlRQnNBRzhBYmdC?=
 =?us-ascii?Q?bEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBRzBBWVFCeUFIWUFaUUJzQUY4QWNB?=
 =?us-ascii?Q?QnlBRzhBYWdCbEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFISUFaUUJ6QUhR?=
 =?us-ascii?Q?QWNnQnBBR01BZEFCbEFHUUFYd0JvQUdVQWVBQmpBRzhBWkFCbEFITUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUdFQWNnQnRBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refthree: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFB?=
 =?us-ascii?Q?QUlBQUFBQUFKNEFBQUJ0QUdFQWNnQjJBR1VBYkFCc0FGOEFad0J2QUc4QVp3?=
 =?us-ascii?Q?QnNBR1VBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFH?=
 =?us-ascii?Q?MEFZUUJ5QUhZQVpRQnNBR3dBWHdCd0FISUFid0JxQUdVQVl3QjBBRjhBWXdC?=
 =?us-ascii?Q?dkFHUUFaUUJ6QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBYlFCaEFISUFkZ0JsQUd3?=
 =?us-ascii?Q?QWJBQmZBSEFBY2dCdkFHb0FaUUJqQUhRQVh3QmpBRzhBWkFCbEFITUFYd0Jr?=
 =?us-ascii?Q?QUdrQVl3QjBBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFB?=
 =?us-ascii?Q?QUFBSUFBQUFBQUo0QUFBQnRBR0VBY2dCMkFHVUFiQUJzQUY4QWNBQnlBRzhB?=
 =?us-ascii?Q?YWdCbEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFHTUFid0J1QUdZQWFRQmtB?=
 =?us-ascii?Q?R1VBYmdCMEFHa0FZUUJzQUY4QWJRQmhBSElBZGdCbEFHd0FiQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FB?=
 =?us-ascii?Q?QUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J3QUhJQWJ3QnFBR1VBWXdCMEFGOEFi?=
 =?us-ascii?Q?Z0JoQUcwQVpRQnpBRjhBWXdCdkFHNEFaZ0JwQUdRQVpRQnVBSFFBYVFCaEFH?=
 =?us-ascii?Q?d0FYd0J0QUdFQWNnQjJBR1VBYkFCc0FGOEFid0J5QUY4QVlRQnlBRzBBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reffour: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFD?=
 =?us-ascii?Q?ZUFBQUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFIQUFjZ0J2QUdvQVpRQmpBSFFB?=
 =?us-ascii?Q?WHdCdUFHRUFiUUJsQUhNQVh3QmpBRzhBYmdCbUFHa0FaQUJsQUc0QWRBQnBB?=
 =?us-ascii?Q?R0VBYkFCZkFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdCdkFISUFYd0JuQUc4QWJ3?=
 =?us-ascii?Q?Qm5BR3dBWlFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCdEFHRUFjZ0Iy?=
 =?us-ascii?Q?QUdVQWJBQnNBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQmZBRzRBWVFCdEFHVUFj?=
 =?us-ascii?Q?d0JmQUhJQVpRQnpBSFFBY2dCcEFHTUFkQUJsQUdRQVh3QnRBR0VBY2dCMkFH?=
 =?us-ascii?Q?VUFiQUJzQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVB?=
 =?us-ascii?Q?QUFBQUFBQUFBZ0FBQUFBQW5nQUFBRzBBWVFCeUFIWUFaUUJzQUd3QVh3QndB?=
 =?us-ascii?Q?SElBYndCcUFHVUFZd0IwQUY4QWJnQmhBRzBBWlFCekFGOEFjZ0JsQUhNQWRB?=
 =?us-ascii?Q?QnlBR2tBWXdCMEFHVUFaQUJmQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J2QUhJ?=
 =?us-ascii?Q?QVh3QmhBSElBYlFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFB?=
 =?us-ascii?Q?QUNlQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUhRQVpRQnlBRzBBYVFCdUFI?=
 =?us-ascii?Q?VUFjd0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ0QUdFQWNn?=
 =?us-ascii?Q?QjJBR1VBYkFCc0FGOEFkd0J2QUhJQVpBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFnQUFBQUFBIi8+PC9tZXRhPg=3D=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR1801MB1883:EE_|SJ0PR18MB4961:EE_
x-ms-office365-filtering-correlation-id: 57ac8c34-d6a6-4dba-c545-08db5c4de188
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OGQkHF8mQ5ghBQ1u1LyX8uwm2usGrc7eg3a6+V0Krl1kOrPYNImj4dhC50gygH2+eX7MQ2uVmRdxVKzoIcTNWEo8gY2YG+TF9yn5vNigiYzgrZCsJVmjyJHk8/gKOVse04PbSv1UKy4Sbkgrjw2Vqaf0kbicuH5g0Zh+60wzj0xE0V59jqQFjuEhW/Gqt1dAnj4sybSRIsc0PetoUKoVc5KPnlVFbUBaTVuaB4noNB70T1qvC7jjJVn5iA6iE+ev0NBCQ0vjWAN2NiPcRdJFA3hlxvxKNfSeQkCp8jsR7NSxYE4Jz4bvAVoZ7nqU6JbH9jdXqH4NPDgzCM7g6mRjxeNWE2NpvJ16N8BjxC2aVmxjv7ODRcADhuR/qegItjP2ORD6MyIqde9yTm3oc5LSdhpHEmOvRJ7zA026LzLwqm6T2TClIIeSlwgPkvM+/0XhHGR81lzN5NvMt2Y2BsE6i6M752Yh+freljBfJAFohCDJI8LffIzgJsJq56NVj0bkwtwCw/XYk3DQiPPJQBUZsHHDnaZQIvCB3xKXBJ5g4TO0/xJw3J0IxzV5zIjTdOpJ85Tu7GbV5q6FIkrvdBY0EuaQ1Sh57jWD7qw1HYhoP+Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1801MB1883.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(451199021)(66556008)(5660300002)(8936002)(8676002)(52536014)(83380400001)(54906003)(86362001)(107886003)(53546011)(9686003)(26005)(55236004)(6506007)(186003)(122000001)(38100700002)(38070700005)(4326008)(33656002)(55016003)(478600001)(7696005)(71200400001)(966005)(6916009)(316002)(41300700001)(19627235002)(64756008)(66446008)(76116006)(2906002)(66476007)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zyFTVytP+Nqxwdvh8ZVvrgu6lZCGSInOM5EUIbq8Oupgurh3dEjcyt9PROVo?=
 =?us-ascii?Q?Bz81m71gTLdOaaviavfmEQ4a2B7yfXXX2+YqyDmsE9YPwpn+PNkv8+qV3sSY?=
 =?us-ascii?Q?MP5xhlqswyLAqAEn0sqX8r/HEu3ySqLjYKSuowX+PIvt+kNloowibnoi8TI/?=
 =?us-ascii?Q?KnTEZbu0Lsi5HLw//5bfUB164i0zAwUA0x90/5VqkYG1jTf3T+ZnmTO/FPlN?=
 =?us-ascii?Q?HGvmaaeaKXzDK4NbGTcCLyqW2C8iXkqX3+nZUN/woSzcsbTkMgCUNLMr/SAk?=
 =?us-ascii?Q?IwSuOGPCsoZIOWDlyzqw+yn2oCe5vyrg5c9weDuKYW2VIp1hzMCqIwvUYiM5?=
 =?us-ascii?Q?mhtknvtv6C2GQDB1wG/llsJ79blc7RozZsbExR/a92A/NbF8hs1h/0Xu3Tup?=
 =?us-ascii?Q?6qEehrYc66kdrAEfgQ2/cLvDIbGN9Grc6u2ziYkGE6nFOdqfyBTH+HUBSw+6?=
 =?us-ascii?Q?AQt5uapoFCuUwwDZZGcudHN/wEu5hHo2oSjrSKswug9gf+DTD9QnL9qCexTv?=
 =?us-ascii?Q?ZDLn7BNg3kPYnDeGP/q5MAyxQQjf4Y0x39MoqUyQgBS+7dxp6fI4/QJ6sKqv?=
 =?us-ascii?Q?Dd4lDXX4fXbE/6bdRmF42IkudJRWWzbQ7C2Nj4fgMC1VdtrLvA2fwjHHfBMo?=
 =?us-ascii?Q?Jll1hBpHfyx3iCQG8kjRuV2vpoazJxQnnkGMJC1ZSP8GJCLF1FY7EBCpuBQx?=
 =?us-ascii?Q?8R9mkX1cI0Xkyx23XLRnrEaBqhxBiC0Ts8GgS4pW33YF8Kyo5UcH/O9Eupjs?=
 =?us-ascii?Q?SIsd077ueyjrOSHmusfp4SwR2NOISyJ0Iv1OvwMw8PvzNx6Sk6Rbq+7PmxoJ?=
 =?us-ascii?Q?rlt2ADP159SEvfInG7hekeeiy5/ZvsCNMsZ/LdaIi3SCBIqdh+LlbnVPxxS7?=
 =?us-ascii?Q?qLBdPVperQ926L07UQ4AsoXOS7DYZuFK+BCX+R96wgqnecLfd8FY1jtI4g7R?=
 =?us-ascii?Q?wPlp0sxQw0gyeMY9ELv085ITQrP2q+R9PNUTaN7L9V3sXinbHeq8cbL/cvjL?=
 =?us-ascii?Q?IMdI9jdPuuM7pIYkxQhyP/RAOY9YOO2HhTAes2cSTJYXhdfOA1KebdVlEC9e?=
 =?us-ascii?Q?Cv4/F2ROCqSAkKmK7vpI4HYDpdJLCkBXgDYBYsMEmgmnW86l+gzYKhkZIHHd?=
 =?us-ascii?Q?q6ECRgDsLO33nO2+Of5wEOKmpR+pbIHs8iHodmuE2h2MX8PPd9v2h6QXa7BW?=
 =?us-ascii?Q?1J10+tRol/wpdkLvs2ji0a0dix1pBBtAq5AvvQiGqlk4MDAxGCUgBiWEALmx?=
 =?us-ascii?Q?tnpiWsPsj9uUl7k5fbm7FcNqfnpeHynPgdsjDzcIqPcNM1hvCMsgI1I5LTtl?=
 =?us-ascii?Q?LjPNql5WfIWUCd7Vgz0jcHq71hm0RCCnneDcM/5/N+ISJ5dU9gAx67Cc8vb+?=
 =?us-ascii?Q?79pDQW9AiBcmY122twSZASIJlM1UtX6eAAymqGdSkOM3F1d0gpb39pLYzE3y?=
 =?us-ascii?Q?lJ31N1/XBO+sSXXD/jdWObpqq9XMEdGnKKJTx/7bU2Tkt2Vi0oQRuJgZO2ru?=
 =?us-ascii?Q?EzRTxvh2hJImZQbinF0kyr2i0f0neHZ9ezsK2t1PoJpOCPZ3wIiDc2ZAW33B?=
 =?us-ascii?Q?TrsoQAS3MjV1eLw6h0G+VIzwA3teo6MzjTowIua4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1801MB1883.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ac8c34-d6a6-4dba-c545-08db5c4de188
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 11:56:16.8724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IRjnS6RXB+PWfFzQy+kWU2J/nC5AJNaDiNglTmT762xHKqbLBYJAwn4WdeEmgcTH/njkXXKIqoUrj8TzOEmHaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB4961
X-Proofpoint-ORIG-GUID: RRl_QJxkzF2EcgbsCUYOSmslIk7yQiHr
X-Proofpoint-GUID: RRl_QJxkzF2EcgbsCUYOSmslIk7yQiHr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_07,2023-05-24_01,2023-05-22_02
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Herbert Xu <herbert@gondor.apana.org.au>
> Sent: Wednesday, May 24, 2023 3:26 PM
> To: Bharat Bhushan <bbhushan2@marvell.com>
> Cc: olivia@selenic.com; Jason@zx2c4.com; linux-crypto@vger.kernel.org; li=
nux-
> kernel@vger.kernel.org; Sunil Kovvuri Goutham <sgoutham@marvell.com>
> Subject: [EXT] Re: [PATCH] hwrng: cn10k: Add extended trng register suppo=
rt
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On Thu, May 18, 2023 at 12:17:34PM +0530, Bharat Bhushan wrote:
> >
> > -static void cn10k_read_trng(struct cn10k_rng *rng, u64 *value)
> > +static size_t cn10k_read_trng(struct cn10k_rng *rng, u64 *value)
>=20
> Since the return value is either 0 or 8, why did you pick size_t as the r=
eturn value?

This function returns number of valid bytes available in "value". 0 means n=
o valid data. size_t is definitely wrong.
I think I will make this function to return bool, true when data is valid a=
nd false when data is not valid.

Thanks
-Bharat

>=20
> >  {
> > +	u16 retry_count =3D 0;
> >  	u64 upper, lower;
> > +	u64 status;
> > +
> > +	if (rng->extended_trng_regs) {
> > +		do {
> > +			*value =3D readq(rng->reg_base + RNM_PF_TRNG_DAT);
> > +			if (*value)
> > +				return 8;
> > +			status =3D readq(rng->reg_base + RNM_PF_TRNG_RES);
> > +			if (!status && (retry_count++ > 0x1000))
> > +				return 0;
> > +		} while (!status);
> > +	}
> >
> >  	*value =3D readq(rng->reg_base + RNM_PF_RANDOM);
> >
> > @@ -82,6 +130,7 @@ static void cn10k_read_trng(struct cn10k_rng *rng,
> > u64 *value)
> >
> >  		*value =3D (upper & 0xFFFFFFFF00000000) | (lower & 0xFFFFFFFF);
> >  	}
> > +	return 8;
> >  }
> >
> >  static int cn10k_rng_read(struct hwrng *hwrng, void *data, @@ -100,7
> > +149,9 @@ static int cn10k_rng_read(struct hwrng *hwrng, void *data,
> >  	size =3D max;
> >
> >  	while (size >=3D 8) {
> > -		cn10k_read_trng(rng, &value);
> > +		err =3D cn10k_read_trng(rng, &value);
> > +		if (!err)
> > +			goto out;
>=20
> It appears that err is either 8 or 0, so it's not really an error.
> Could you plesae use a more meaningful name for this variable?
>=20
> Cheers,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au> Home Page:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__gondor.apana.org.au=
_-
> 7Eherbert_&d=3DDwIBAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DPAAlWswPe7d8gHlGb
> CLmy2YezyK7O3Hv_t2heGnouBw&m=3DYa8SJ6OhypttG2itpa39dd7kXwEXGgbUOJ2
> Hqi95w7MetfxqRKKFX7aluHaLZpoc&s=3DpnRAp3oSzsNrbEAHZdLM6Eb9M4tDMxEd
> WLzANKejHwU&e=3D
> PGP Key: https://urldefense.proofpoint.com/v2/url?u=3Dhttp-
> 3A__gondor.apana.org.au_-
> 7Eherbert_pubkey.txt&d=3DDwIBAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DPAAlWswP
> e7d8gHlGbCLmy2YezyK7O3Hv_t2heGnouBw&m=3DYa8SJ6OhypttG2itpa39dd7kXwE
> XGgbUOJ2Hqi95w7MetfxqRKKFX7aluHaLZpoc&s=3DpLpT-
> xdKvVvCI4sp5r8r5qYoKeEx537Gnlkq1dpTrYY&e=3D
