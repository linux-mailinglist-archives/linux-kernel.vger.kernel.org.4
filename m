Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43206627BA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 14:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236755AbjAINuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 08:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237264AbjAINto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 08:49:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF89A2F787
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 05:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673272137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NqUCAZbaNLI+BrA/h8UtdwPusw7D5gv6g1VhKXRC0SU=;
        b=T465wyB0a/P9xapr7+xqfRrWYJoTlVpP8iE8XNgzXmx/O4Y/u7tI0CAWiQVLy1FwbrQmXQ
        dw4aojFF7MFRrQUtfLOCYVJ6p+UFWRiREt47JBQgG6BfayOnF8jJAPIrFPXXt+d2P8X/C+
        +OFS+8pcjrggp3o79PNr/Pq+JI/JyGk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-210-FE2u8eMaMMSH_6EF-YdwfA-1; Mon, 09 Jan 2023 08:48:56 -0500
X-MC-Unique: FE2u8eMaMMSH_6EF-YdwfA-1
Received: by mail-pj1-f69.google.com with SMTP id h12-20020a17090a604c00b00225b2dbe4cfso3114408pjm.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 05:48:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NqUCAZbaNLI+BrA/h8UtdwPusw7D5gv6g1VhKXRC0SU=;
        b=tp80yLxA0eH0iGvZSktnsf+clXblTLMdE5THHOFz/SlyD62n0hA3CVjZXuJksoSiFS
         izSqySAeNYEiNQhiBZvJYyxZ4zU8DYdupdclYLQqkwWB+jMNqfHClonh46M4+Dgog8t4
         3y/u/O1hiQ/tHTVh4CytRvS/niqiEYCyMH2lIGyGeBHJc4BCN7RzEcLgQKvi0WprrV64
         rA6cBFsgOwjRqpuq32sPm/PDlUH/4o05Mnv12KKYOelax+n2foUQzsWHvQq/wlmSJNq4
         HmWJvf0OVK3WIBeIITfQ+ltQwigfXm/3ja9wTGdF0y5DDaurG83B7pjwdBRoUL/YxR28
         hWEA==
X-Gm-Message-State: AFqh2krbtz5OwK9MRa4lzKG0RyYzfKwvCRndBxVqZTHi7pm4n6uZf0ja
        A1ZSXRKItAWveCUBlC4LRBqxtz9Ciol6KqdRowvfKX+6yC3NtboCGj1cGYiQIztwGUWKg/d+OAg
        drVfQoOMbrVrO9uc/PNbbX+gf
X-Received: by 2002:a17:902:7288:b0:193:24bf:344d with SMTP id d8-20020a170902728800b0019324bf344dmr6294934pll.57.1673272134524;
        Mon, 09 Jan 2023 05:48:54 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvgQ1KW/WDU2jxQ3Px8VVv1KWvd4mBA2JdiH9huI3h8STXP3IpST+se5m3+Pp8YlNIr0RJVnw==
X-Received: by 2002:a17:902:7288:b0:193:24bf:344d with SMTP id d8-20020a170902728800b0019324bf344dmr6294909pll.57.1673272134200;
        Mon, 09 Jan 2023 05:48:54 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id k7-20020a170902ce0700b001885d15e3c1sm6183354plg.26.2023.01.09.05.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 05:48:53 -0800 (PST)
Subject: Re: [PATCH v9 1/4] Documentation: fpga: dfl: Add documentation for
 DFHv1
To:     matthew.gerlach@linux.intel.com, hao.wu@intel.com,
        yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tianfei.zhang@intel.com,
        corbet@lwn.net, gregkh@linuxfoundation.org,
        linux-serial@vger.kernel.org, jirislaby@kernel.org,
        geert+renesas@glider.be, andriy.shevchenko@linux.intel.com,
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, lukas@wunner.de, ilpo.jarvinen@linux.intel.com,
        marpagan@redhat.com, bagasdotme@gmail.com
References: <20230104232253.24743-1-matthew.gerlach@linux.intel.com>
 <20230104232253.24743-2-matthew.gerlach@linux.intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <4e7f84ff-8bab-019d-3858-4c545834a354@redhat.com>
Date:   Mon, 9 Jan 2023 05:48:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230104232253.24743-2-matthew.gerlach@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/4/23 3:22 PM, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>
> Add documentation describing the extensions provided by Version
> 1 of the Device Feature Header (DFHv1).
>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Thanks for the changes.

Reviewed-by: Tom Rix <trix@redhat.com>

> ---
> v9: move DFH definitions to after the Overview
>      fix name of feature revision field
>      clarify next field in DFH
>
> v8: fix section titles
>
> v7: shorten long lines and wording suggestions by bagasdotme@gmail.com
>
> v6: no change
>
> v5: use nested list for field descriptions
>      clean up prose
>      add reviewed-by and comments from Ilpo Järvinen
>
> v4: Remove marketing speak and separate v0 and v1 descriptions.
>      Fix errors reported by "make htmldocs".
>
> v3: no change
>
> v2: s/GUILD/GUID/
>      add picture
> ---
>   Documentation/fpga/dfl.rst | 117 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 117 insertions(+)
>
> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> index 15b670926084..7e015249785b 100644
> --- a/Documentation/fpga/dfl.rst
> +++ b/Documentation/fpga/dfl.rst
> @@ -75,6 +75,123 @@ convenient for software to locate each feature by walking through this list,
>   and can be implemented in register regions of any FPGA device.
>   
>   
> +Device Feature Header - Version 0
> +=================================
> +Version 0 (DFHv0) is the original version of the Device Feature Header.
> +The format of DFHv0 is shown below::
> +
> +    +-----------------------------------------------------------------------+
> +    |63 Type 60|59 DFH VER 52|51 Rsvd 41|40 EOL|39 Next 16|15 REV 12|11 ID 0| 0x00
> +    +-----------------------------------------------------------------------+
> +    |63                                 GUID_L                             0| 0x08
> +    +-----------------------------------------------------------------------+
> +    |63                                 GUID_H                             0| 0x10
> +    +-----------------------------------------------------------------------+
> +
> +- Offset 0x00
> +
> +  * Type - The type of DFH (e.g. FME, AFU, or private feature).
> +  * DFH VER - The version of the DFH.
> +  * Rsvd - Currently unused.
> +  * EOL - Set if the DFH is the end of the Device Feature List (DFL).
> +  * Next - The offset in bytes of the next DFH in the DFL from the DFH start,
> +    and the start of a DFH must be aligned to an 8 byte boundary.
> +    If EOL is set, Next is the size of MMIO of the last feature in the list.
> +  * REV - The revision of the feature associated with this header.
> +  * ID - The feature ID if Type is private feature.
> +
> +- Offset 0x08
> +
> +  * GUID_L - Least significant 64 bits of a 128-bit Globally Unique Identifier
> +    (present only if Type is FME or AFU).
> +
> +- Offset 0x10
> +
> +  * GUID_H - Most significant 64 bits of a 128-bit Globally Unique Identifier
> +    (present only if Type is FME or AFU).
> +
> +
> +Device Feature Header - Version 1
> +=================================
> +Version 1 (DFHv1) of the Device Feature Header adds the following functionality:
> +
> +* Provides a standardized mechanism for features to describe
> +  parameters/capabilities to software.
> +* Standardize the use of a GUID for all DFHv1 types.
> +* Decouples the DFH location from the register space of the feature itself.
> +
> +The format of Version 1 of the Device Feature Header (DFH) is shown below::
> +
> +    +-----------------------------------------------------------------------+
> +    |63 Type 60|59 DFH VER 52|51 Rsvd 41|40 EOL|39 Next 16|15 REV 12|11 ID 0| 0x00
> +    +-----------------------------------------------------------------------+
> +    |63                                 GUID_L                             0| 0x08
> +    +-----------------------------------------------------------------------+
> +    |63                                 GUID_H                             0| 0x10
> +    +-----------------------------------------------------------------------+
> +    |63                   Reg Address/Offset                      1|  Rel  0| 0x18
> +    +-----------------------------------------------------------------------+
> +    |63        Reg Size       32|Params 31|30 Group    16|15 Instance      0| 0x20
> +    +-----------------------------------------------------------------------+
> +    |63 Next    35|34RSV33|EOP32|31 Param Version 16|15 Param ID           0| 0x28
> +    +-----------------------------------------------------------------------+
> +    |63                 Parameter Data                                     0| 0x30
> +    +-----------------------------------------------------------------------+
> +
> +                                  ...
> +
> +    +-----------------------------------------------------------------------+
> +    |63 Next    35|34RSV33|EOP32|31 Param Version 16|15 Param ID           0|
> +    +-----------------------------------------------------------------------+
> +    |63                 Parameter Data                                     0|
> +    +-----------------------------------------------------------------------+
> +
> +- Offset 0x00
> +
> +  * Type - The type of DFH (e.g. FME, AFU, or private feature).
> +  * DFH VER - The version of the DFH.
> +  * Rsvd - Currently unused.
> +  * EOL - Set if the DFH is the end of the Device Feature List (DFL).
> +  * Next - The offset in bytes of the next DFH in the DFL from the DFH start,
> +    and the start of a DFH must be aligned to an 8 byte boundary.
> +    If EOL is set, Next is the size of MMIO of the last feature in the list.
> +  * REV - The revision of the feature associated with this header.
> +  * ID - The feature ID if Type is private feature.
> +
> +- Offset 0x08
> +
> +  * GUID_L - Least significant 64 bits of a 128-bit Globally Unique Identifier.
> +
> +- Offset 0x10
> +
> +  * GUID_H - Most significant 64 bits of a 128-bit Globally Unique Identifier.
> +
> +- Offset 0x18
> +
> +  * Reg Address/Offset - If Rel bit is set, then the value is the high 63 bits
> +    of a 16-bit aligned absolute address of the feature's registers. Otherwise
> +    the value is the offset from the start of the DFH of the feature's registers.
> +
> +- Offset 0x20
> +
> +  * Reg Size - Size of feature's register set in bytes.
> +  * Params - Set if DFH has a list of parameter blocks.
> +  * Group - Id of group if feature is part of a group.
> +  * Instance - Id of feature instance within a group.
> +
> +- Offset 0x28 if feature has parameters
> +
> +  * Next - Offset to the next parameter block in 8 byte words. If EOP set,
> +    size in 8 byte words of last parameter.
> +  * Param Version - Version of Param ID.
> +  * Param ID - ID of parameter.
> +
> +- Offset 0x30
> +
> +  * Parameter Data - Parameter data whose size and format is defined by
> +    version and ID of the parameter.
> +
> +
>   FIU - FME (FPGA Management Engine)
>   ==================================
>   The FPGA Management Engine performs reconfiguration and other infrastructure

