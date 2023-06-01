Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0066471F0D4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 19:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjFARcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 13:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjFARcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 13:32:16 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2092.outbound.protection.outlook.com [40.107.10.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A634E4;
        Thu,  1 Jun 2023 10:32:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CI2QuGcPVlUkSkqzWy39ykBXkeDsX9TQkmWm29NiGt/dlba3TQmp/QDV+q481h763qurdy+GdKZvlQTxtCJGJwpTZ1z2wnNNotGHXX46TUneHvQoxyNkaIofuRMG8aH/wMLDk/eVE3e8BwtXndCB1IyucClT5w1Phazz7b433FbVa/PNEmofsQ2E7zgLRNQleCIdNlGeIADNTZHL96TcWU5QCsBku9h7tcVIY11N6W6LrxeckVkx2tTyYKK1Oa/3xztDiPASuybjNiF742D+hP4RFKvjLJ1yIWTEpX3xW2bqUjtAph1EIcNyXAjFQfbH9JuqC+9hLv6Shh9xeYx5XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oFbj3xbAxkuFVUlJS7R2ul3JZ+NTfOsPahmTvZnxJbg=;
 b=CRBe/K3SZnDW0nE2w8yWt1HqXfg0OSa1Ri6QqnmefCmWWN6spt52MakUYspyfdwrHKJ/IdYs9Rlw3fCqwYg7UsQu3B1N8KoxmjvJ7nuhcIHISla8rMYQLvkAadSyx9m6wJauBdsQhdR5CGxwiJ4PgcroG7t3uyhGCf/v9DhZk1F69Hl79HBip3Wfmq3qcUx9obzz+j7qAjWLEYUBGsQgHRPCdf2wyywKW33K+F0eMQmadUB4/rXZ446kzUq2MpQjTI8tZiKF3zlvM/L5yzsUugRqVHRhigD9EmMNeo+dyuZxZJSY2qPpRAqF2EiCoBuG694LcCkq57fvrxYgWI3AbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFbj3xbAxkuFVUlJS7R2ul3JZ+NTfOsPahmTvZnxJbg=;
 b=zyXzkP2ITyMqj1l+yNjAmWtVIhBSfvdgZ3GNfGvWIWyFEBwf4J6SnfRCxvng90ffJmzIo5iwxDitbPDXbvCVu1M9aH0q9KivT5zm00kDn6aoA82aE8HBzz8hRJDc5MqHPj0/zUPXaPxtslkDDX9dEJbcZLBbPHbEpTBCLx1Kg18=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO6P265MB6987.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:321::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.9; Thu, 1 Jun
 2023 17:32:11 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2e6d:c339:6006:9013]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2e6d:c339:6006:9013%5]) with mapi id 15.20.6477.008; Thu, 1 Jun 2023
 17:32:11 +0000
Date:   Thu, 1 Jun 2023 18:32:09 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "=?UTF-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v2 8/8] rust: workqueue: add examples
Message-ID: <20230601183209.371fd898.gary@garyguo.net>
In-Reply-To: <20230601134946.3887870-9-aliceryhl@google.com>
References: <20230601134946.3887870-1-aliceryhl@google.com>
        <20230601134946.3887870-9-aliceryhl@google.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0106.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::21) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO6P265MB6987:EE_
X-MS-Office365-Filtering-Correlation-Id: 865f09ee-a4ea-46f4-9555-08db62c621d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vaWdJOI/sU27OMgZGMU6Ykvh4MtttAmeA/OUfCScw89vV4mV6/adgQuSNUVI0a7jI8PBQuNNmfva4s+Wy0QKQc7IbG7nx0+1+mIf+mh6tHrdhoZEnXLAanHfq77g5ZfY1N/KkzTQ5ow6hsD0ZJ7DSZBLSmkjWE7qiFppYcDJcDyt9utikK9QCY4bP9BsnuNDwcIa5eIy4FQyTbFfV0tkbHfFg9O9n9R7jdkh0kY+HCDoIF8HI6eur8Ht2Dbv+++LCn4ZOz+yoW8pBVWzsMnC6gEPaN69xm08EtKOnxUdb9V3UfhrbN4AYQLb4XtG+jUTqdIgM5JuFb4ggfYnM36lnsrHDzKpxC7emJ8wf9cDjx1v8KZxsxkhxnSafSK7So/2YKRQyITQUayrITTgAd9AbukVnvPlDVKJ+zjI6zw5Kv1XrVOQDaHsrXmAM95qwuZdpC41uaXbEMoeH00aauGIFpIfALM3z08HVgcucEkOiJvhwCjU/VjytCTLa+sBYfotoB9iz2F0kIEyCcYKFh5NTqOpYuIprrCUzeQ+YyiOtf1Lcv3hrr+oIl8aSMvfRIe4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(346002)(39830400003)(376002)(366004)(136003)(396003)(451199021)(38100700002)(7416002)(2906002)(41300700001)(316002)(8676002)(8936002)(83380400001)(5660300002)(6486002)(6916009)(66946007)(66556008)(4326008)(66476007)(2616005)(36756003)(86362001)(186003)(1076003)(54906003)(26005)(6512007)(478600001)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vql5g18yLzlwT1NnvyKg39vjKwd75rxvg2p5PCKYXcXFt/QuyFPOs8pye2dd?=
 =?us-ascii?Q?qAwYJi/wnVDkn2wbP/g2SxfTI+iD+GP8GJJS2SKKod0RdipDylCsyzb1B1cz?=
 =?us-ascii?Q?bVeObPOPuPJ4RQ2VKL7YXiHU9wKvAiZXg+XKUN+qWw6b3IXOyUpgwC7lx/5k?=
 =?us-ascii?Q?h4pTNdNlP1IJq/i+w1iiE2ZXK0hl+JRc6Wt8Kn3LRwZC9GBmLrm5qqqL9hXp?=
 =?us-ascii?Q?W6Yek+Mz8hAeO5tpVAISc9kZN1uTGHGzlSGgxsutvVOGlaHXNibW/QzYcxiC?=
 =?us-ascii?Q?xEBCIIlRbh07KGqGw4NATiHo3g+jtcA/JHahFNYaA+7U1HUYCVB5Jks+anUa?=
 =?us-ascii?Q?+grgPbGhfaPOPUWSzbNo0/XAUDqUKCayR3ySF0HQVXQ2MbrgxvPX4vtJcB+l?=
 =?us-ascii?Q?UAHllB24KV4VyE0EKZdD6OTtTz8feFKf0dmI9oHh9xri4keoiJG2j7gjSQ+E?=
 =?us-ascii?Q?PBlGRUtxMbuvdJ0+pr6u7VENF129GyiOsDARQZe9ES1SezWjkXQ3PZ5x0mBl?=
 =?us-ascii?Q?gVvpTW10TZknWG9KEvI6L3JHZojmFMtMe3i5InUsYWGscalrcZujow/EM4Y5?=
 =?us-ascii?Q?NCAxlqzTKRv6ma7yu/m1AAFmEn77eh6BouY76OHJDqlgJyjOqOwtabf+LkhK?=
 =?us-ascii?Q?PfqtHFpz0GEK8baUO0JWbUalfpJ/k018RGI+qs0lhHnu0GnE//gxi4122RSp?=
 =?us-ascii?Q?MiKe899R5MOJtyaeOioaZukNBlfcAiktsn9QP1eepp7w6HuhdJ0iGsp8zCdt?=
 =?us-ascii?Q?f1RKHNkyKDqoxnMjHCpeGwacZdoQ9ltvSoXuUC7YP2E56Hamfvf4qRYQEo7e?=
 =?us-ascii?Q?cME7G2XF4mZJWhtqmIll9Q3UVxoWuCwtV5ZazSv4FOfjQNRrCmFbt8vFo6cR?=
 =?us-ascii?Q?flKlqWhttvgM5mSgUAD8CDRGWgLu8qs+e5LGK4/AbHLbGKzy+FbOPejXEJrB?=
 =?us-ascii?Q?XtPssoqEq4Qol9ipUVeDleMXcuJa1ZnUJ1hs288CNHXHlU+HfE3Pm3Pnw1YE?=
 =?us-ascii?Q?MzjKfXF5fMwDq2qU3RKu48bn9PZJ0pIdfefKHOIa5+2n9VhzQHFrZ+BMJdbx?=
 =?us-ascii?Q?4W9f+MQHneamLudccixZNlXdIhFW0nWrqcabkXPO+Ddfu05kzCuPKcp50814?=
 =?us-ascii?Q?SywqEiUqB18k4QMoQpUxhTLgcgeroB8jghZcWwIP/Z4hlIgiXg3RFfzGhJQX?=
 =?us-ascii?Q?exKc/KLT6v+1abDVDNojA82SwHmBbbhU97gU27tVlCgM337GHJAwB9+2tdWg?=
 =?us-ascii?Q?n+qHZL81T1BQqE7RycZs8UYOWpLlcefMOobpPW4CZrOqKnttY9piTh2PfCch?=
 =?us-ascii?Q?1yxVMngrkUgNaLXMCmf/zXDBxf1+hulmTfHGDRjyPzlpOey5DcKOAWiEP5bS?=
 =?us-ascii?Q?gDz/XVPjLv9eshYnmrCTLGkN9WDaVTqP1lmq+lT4Sfx4r08nU18wEg844ZAq?=
 =?us-ascii?Q?HNqHkinqqe8uzs8VFzwtQqlfD99X7RTtg3o2lZFmV+GNGRj07QTMu0WiwJHL?=
 =?us-ascii?Q?xk88l+kwXAMtrWrqlVvWZI5odMYz5bbsWRbZaYtsFUeLzHiqnFMkL10BczAR?=
 =?us-ascii?Q?fkIzhGkNsyuuTtttnWOzuWGnLmJy6bpEcxaS2uDN?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 865f09ee-a4ea-46f4-9555-08db62c621d7
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 17:32:11.5029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J0e4Tq0uQzSFp2I8DOTwLaXB4veMBLLKBDWBrSo2Lzj6Hg1Xa+Hx2Y7JjcXjiu47MTj62VipT+unTVMYoFjoXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6987
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  1 Jun 2023 13:49:46 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> This adds two examples of how to use the workqueue. The first example
> shows how to use it when you only have one `work_struct` field, and the
> second example shows how to use it when you have multiple `work_struct`
> fields.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/workqueue.rs | 104 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 104 insertions(+)
> 
> diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> index c302e8b8624b..cefcf43ff40e 100644
> --- a/rust/kernel/workqueue.rs
> +++ b/rust/kernel/workqueue.rs
> @@ -26,6 +26,110 @@
>  //!  * The `WorkItemPointer` trait is implemented for the pointer type that points at a something
>  //!    that implements `WorkItem`.
>  //!
> +//! ## Example
> +//!
> +//! This example defines a struct that holds an integer and can be scheduled on the workqueue. When
> +//! the struct is executed, it will print the integer. Since there is only one `work_struct` field,
> +//! we do not need to specify ids for the fields.
> +//!
> +//! ```
> +//! use kernel::prelude::*;
> +//! use kernel::sync::Arc;
> +//! use kernel::workqueue::{self, Work, WorkItem};
> +//!
> +//! #[pin_data]
> +//! struct MyStruct {
> +//!     value: i32,
> +//!     #[pin]
> +//!     work: Work<MyStruct>,
> +//! }
> +//!
> +//! impl_has_work! {
> +//!     impl HasWork<Self> for MyStruct { self.work }
> +//! }
> +//!
> +//! impl MyStruct {
> +//!     fn new(value: i32) -> Result<Arc<Self>> {
> +//!         Arc::pin_init(pin_init!(MyStruct {
> +//!             value,
> +//!             work <- Work::new(),
> +//!         }))
> +//!     }
> +//! }
> +//!
> +//! impl WorkItem for MyStruct {
> +//!     type Pointer = Arc<MyStruct>;
> +//!
> +//!     fn run(this: Arc<MyStruct>) {
> +//!         pr_info!("The value is: {}", this.value);
> +//!     }
> +//! }
> +//!
> +//! /// This method will enqueue the struct for execution on the system workqueue, where its value
> +//! /// will be printed.
> +//! fn print_later(val: Arc<MyStruct>) {
> +//!     let _ = workqueue::system().enqueue(val);
> +//! }
> +//! ```
> +//!
> +//! The following example shows how multiple `work_struct` fields can be used:
> +//!
> +//! ```
> +//! use kernel::prelude::*;
> +//! use kernel::sync::Arc;
> +//! use kernel::workqueue::{self, Work, WorkItem};
> +//!
> +//! #[pin_data]
> +//! struct MyStruct {
> +//!     value_1: i32,
> +//!     value_2: i32,
> +//!     #[pin]
> +//!     work_1: Work<MyStruct, 1>,
> +//!     #[pin]
> +//!     work_2: Work<MyStruct, 2>,
> +//! }
> +//!
> +//! impl_has_work! {
> +//!     impl HasWork<Self, 1> for MyStruct { self.work_1 }
> +//!     impl HasWork<Self, 2> for MyStruct { self.work_2 }
> +//! }
> +//!
> +//! impl MyStruct {
> +//!     fn new(value_1: i32, value_2: i32) -> Result<Arc<Self>> {
> +//!         Arc::pin_init(pin_init!(MyStruct {
> +//!             value_1,
> +//!             value_2,
> +//!             work_1 <- Work::new(),
> +//!             work_2 <- Work::new(),
> +//!         }))
> +//!     }
> +//! }
> +//!
> +//! impl WorkItem<1> for MyStruct {
> +//!     type Pointer = Arc<MyStruct>;
> +//!
> +//!     fn run(this: Arc<MyStruct>) {
> +//!         pr_info!("The value is: {}", this.value_1);
> +//!     }
> +//! }
> +//!
> +//! impl WorkItem<2> for MyStruct {
> +//!     type Pointer = Arc<MyStruct>;
> +//!
> +//!     fn run(this: Arc<MyStruct>) {
> +//!         pr_info!("The second value is: {}", this.value_2);
> +//!     }
> +//! }
> +//!
> +//! fn print_1_later(val: Arc<MyStruct>) {
> +//!     let _ = workqueue::system().enqueue::<Arc<MyStruct>, 1>(val);

Nothing bad about explicit, but I just want to confirm that you could
write

	let _ = workqueue::system().enqueue::<_, 1>(val);

here, right?

Reviewed-by: Gary Guo <gary@garyguo.net>

> +//! }
> +//!
> +//! fn print_2_later(val: Arc<MyStruct>) {
> +//!     let _ = workqueue::system().enqueue::<Arc<MyStruct>, 2>(val);
> +//! }
> +//! ```
> +//!
>  //! C header: [`include/linux/workqueue.h`](../../../../include/linux/workqueue.h)
>  
>  use crate::{bindings, prelude::*, sync::Arc, types::Opaque};

