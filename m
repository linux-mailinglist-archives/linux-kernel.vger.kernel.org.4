Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C38F601395
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 18:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiJQQh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 12:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiJQQhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 12:37:24 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BFE6DFB1;
        Mon, 17 Oct 2022 09:37:22 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MrjKQ0Klrz685Yk;
        Tue, 18 Oct 2022 00:35:38 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 18:37:19 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 17:37:19 +0100
Date:   Mon, 17 Oct 2022 17:37:17 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC V2 PATCH 05/11] cxl/mem: Trace General Media Event Record
Message-ID: <20221017173717.00005921@huawei.com>
In-Reply-To: <Y0nx1UOeYfQu5WYO@iweiny-desk3>
References: <20221010224131.1866246-1-ira.weiny@intel.com>
        <20221010224131.1866246-6-ira.weiny@intel.com>
        <20221011135702.00006f74@huawei.com>
        <Y0nx1UOeYfQu5WYO@iweiny-desk3>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >   
> > > diff --git a/include/trace/events/cxl.h b/include/trace/events/cxl.h
> > > index 318ba5fe046e..82a8d3b750a2 100644
> > > --- a/include/trace/events/cxl.h
> > > +++ b/include/trace/events/cxl.h
> > > @@ -122,6 +122,114 @@ TRACE_EVENT(generic_event,  
> > 
> >   
> > > +#define CXL_GMER_VALID_CHANNEL				BIT(0)
> > > +#define CXL_GMER_VALID_RANK				BIT(1)
> > > +#define CXL_GMER_VALID_DEVICE				BIT(2)
> > > +#define CXL_GMER_VALID_COMPONENT			BIT(3)
> > > +#define show_valid_flags(flags)	__print_flags(flags, "|",		   \
> > > +	{ CXL_GMER_VALID_CHANNEL,			"CHANNEL"	}, \
> > > +	{ CXL_GMER_VALID_RANK,				"RANK"		}, \
> > > +	{ CXL_GMER_VALID_DEVICE,			"DEVICE"	}, \
> > > +	{ CXL_GMER_VALID_COMPONENT,			"COMPONENT"	}  \
> > > +)  
> > 
> > I'd still rather we only had the TP_printk only print those parts that are valid
> > rather than the mess of having to go check the validity bit before deciding whether
> > to take notice of the field.  But meh, not that important given thats
> > not the main intended way to consume this data.
> >   
> 
> Ok I spent some time really thinking about this and below is an attempt at
> that.
> 
> However, I must be missing something in what you are proposing because I don't
> like having extra space in the trace buffer to print into like this and I
> can't figure out where else to put a print buffer.

Putting the space in the trace buffer definitely doesn't makes sense.
Ah. Looking back the CCIX code I assumed it was serialized so could use a
static buffer.

Looking at other similar cases though and we have a lot of use
of trace_seq_printf() e.g. libata_trace_parse_status() though note
there is some magic macro stuff in include/trace/events/libata.h 
to tie that together.
https://elixir.bootlin.com/linux/latest/source/drivers/ata/libata-trace.c#L14

That seems to get you access to the actual buffer we are printing into
in similar cases.

> 
> Also note that this will have no impact on most of the user space tools which
> use libtracefs as they will see all the fields and will need to do a similar
> decode.
> 
> Do you really think this is worth the effort?

With the allocation problem, definitely not. With that solved, it's not a huge amount
of extra code.  Also rather nicely 'documents' meaning of the valid bits.

I'm a kernel hacker. I like to not need much beyond echo and cat :)

Jonathan

> 
> Ira
> 
> 
> commit 54c4ee67bcac6a38cbc9b0ea2ef952e197356dee
> Author: Ira Weiny <ira.weiny@intel.com>
> Date:   Fri Oct 14 16:15:27 2022 -0700
> 
>     squash: Attempt to print only valid fields per Jonathan suggestion
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 2add473fc168..9e15028af79c 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -720,6 +720,28 @@ static const uuid_t gen_media_event_uuid =
>         UUID_INIT(0xfbcd0a77, 0xc260, 0x417f,
>                   0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6);
>  
> +const char *cxl_gem_print_valid(u8 *buf, int nr, u16 valid_flags, u8 channel,
> +                               u8 rank, u32 device, u8 *comp_id)
> +{
> +       char *str = buf;
> +       int rc = 0;
> +
> +       if (valid_flags & CXL_GMER_VALID_CHANNEL)
> +               rc = snprintf(str, nr, "channel=%u ", channel);
> +
> +       if (valid_flags & CXL_GMER_VALID_RANK)
> +               rc = snprintf(str + rc, nr - rc, "rank=%u ", rank);
> +
> +       if (valid_flags & CXL_GMER_VALID_DEVICE)
> +               rc = snprintf(str + rc, nr - rc, "device=%u ", device);
> +
> +       if (valid_flags & CXL_GMER_VALID_COMPONENT)
> +               rc = snprintf(str + rc, nr - rc, "comp_id=%*ph ",
> +                             CXL_EVENT_GEN_MED_COMP_ID_SIZE, comp_id);
> +
> +       return str;
> +}
> +
>  static void cxl_trace_event_record(const char *dev_name,
>                                    enum cxl_event_log_type type,
>                                    struct cxl_get_event_payload *payload)
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 8fbd20d8a0b2..3d3bfef69d32 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -429,6 +429,13 @@ struct cxl_event_gen_media {
>         u8 reserved[0x2e];
>  } __packed;
>  
> +#define CXL_GMER_VALID_CHANNEL                         BIT(0)
> +#define CXL_GMER_VALID_RANK                            BIT(1)
> +#define CXL_GMER_VALID_DEVICE                          BIT(2)
> +#define CXL_GMER_VALID_COMPONENT                       BIT(3)
> +const char *cxl_gem_print_valid(u8 *buf, int nr, u16 valid_flags, u8 channel,
> +                               u8 rank, u32 device, u8 *comp_id);
> +
>  struct cxl_mbox_get_partition_info {
>         __le64 active_volatile_cap;
>         __le64 active_persistent_cap;
> diff --git a/include/trace/events/cxl.h b/include/trace/events/cxl.h
> index e3e11c9055ba..27bb790cb685 100644
> --- a/include/trace/events/cxl.h
> +++ b/include/trace/events/cxl.h
> @@ -161,16 +161,7 @@ TRACE_EVENT(generic_event,
>         { CXL_GMER_TRANS_INTERNAL_MEDIA_MANAGEMENT,     "Internal Media Management" }   \
>  )
>  
> -#define CXL_GMER_VALID_CHANNEL                         BIT(0)
> -#define CXL_GMER_VALID_RANK                            BIT(1)
> -#define CXL_GMER_VALID_DEVICE                          BIT(2)
> -#define CXL_GMER_VALID_COMPONENT                       BIT(3)
> -#define show_valid_flags(flags)        __print_flags(flags, "|",                  \
> -       { CXL_GMER_VALID_CHANNEL,                       "CHANNEL"       }, \
> -       { CXL_GMER_VALID_RANK,                          "RANK"          }, \
> -       { CXL_GMER_VALID_DEVICE,                        "DEVICE"        }, \
> -       { CXL_GMER_VALID_COMPONENT,                     "COMPONENT"     }  \
> -)
> +#define CXL_VALID_PRINT_STR_LEN 512
>  
>  TRACE_EVENT(general_media,
>  
> @@ -191,6 +182,7 @@ TRACE_EVENT(general_media,
>                 __array(u8, comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE)
>                 __field(u16, validity_flags)
>                 __field(u8, rank) /* Out of order to pack trace record */
> +               __array(u8, str, CXL_VALID_PRINT_STR_LEN)
>         ),
>  
>         TP_fast_assign(
> @@ -209,17 +201,17 @@ TRACE_EVENT(general_media,
>                 __entry->validity_flags = get_unaligned_le16(&rec->validity_flags);
>         ),
>  
> -       CXL_EVT_TP_printk("phys_addr=%llx volatile=%s desc='%s' type='%s' " \
> -               "trans_type='%s' channel=%u rank=%u device=%x comp_id=%s " \
> -               "valid_flags='%s'",
> +       CXL_EVT_TP_printk("phys_addr=%llx volatile=%s desc='%s' type='%s' "     \
> +               "trans_type='%s' %s",
>                 __entry->phys_addr & CXL_GMER_PHYS_ADDR_MASK,
>                 (__entry->phys_addr & CXL_GMER_PHYS_ADDR_VOLATILE) ? "TRUE" : "FALSE",
>                 show_event_desc_flags(__entry->descriptor),
>                 show_mem_event_type(__entry->type),
>                 show_trans_type(__entry->transaction_type),
> -               __entry->channel, __entry->rank, __entry->device,
> -               __print_hex(__entry->comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE),
> -               show_valid_flags(__entry->validity_flags)
> +               cxl_gem_print_valid(__entry->str, CXL_VALID_PRINT_STR_LEN,
> +                                   __entry->validity_flags, __entry->channel,
> +                                   __entry->rank, __entry->device,
> +                                   __entry->comp_id)
>         )
>  );
> 
> 

