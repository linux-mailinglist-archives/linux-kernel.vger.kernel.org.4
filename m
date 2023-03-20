Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B2A6C22BF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 21:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjCTUcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 16:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjCTUcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 16:32:46 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD8C5B99;
        Mon, 20 Mar 2023 13:32:43 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id t129so6023031iof.12;
        Mon, 20 Mar 2023 13:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679344362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C19puc1CjUet0EnZr5hTIF4s8WkcyV5Hqj3hnqm8iww=;
        b=Kf3Qg7ddjIzrSZaWovacFmGN96E8CXjiP25SwSFF4XgtDoCH0LTIXikQ0dxeiOTUhw
         CO3tuebeb3adC1dm/uEoX7prE5Iq8xDFcxeO3SNKUqVrMNOLVDtIXNOduOEQAbXb+BuD
         ETIIV5ZdXegL7q1KY8GpYt6meRwXI8zkbBiKS3HP2XDXqNsrkgbstJTrrXrAog/VPG7w
         5gMF9uigs+YIqRgC519Mhi7OGZfaG79i3qUxE1/Nvw+MQKaVmc7SoN04A3Qhx8gBbG2y
         6GVzTRF4qcsr/0DFfn4B0bGyUBIUuao+RnT9UKFWBtW3YmEFn26yFsSyOxLWFhYQjSfU
         Qp0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679344362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C19puc1CjUet0EnZr5hTIF4s8WkcyV5Hqj3hnqm8iww=;
        b=4R33+qTQhQceR/2TtXcjPWBd6kiOB8alspcKwwEIsEz7tFer3zmsEvxcUuguUc9BOp
         uyYU/Yk6ZzJUl8EX1otDc2e1g9Hs1hy+g5eVYcOlQS6oILf0OnesFc6ITr3CKVKCOmW+
         CWA5Ar3uiryA9ilKi8ADzV6G3ojAaDZpvr2dQYKDrcHBSjSRHVaLtr+Grzl+BQZOhQQm
         Bu9zJUfomTFvMUTrJAnPIvOPaT+iVjWZP6GAWEV/lVFjZISMXzaGbbkj98njw2x0iVmg
         F5r7wUmtL7j2UMwHeUCyBmgLV92IRoJ374ejuibgMXihA12lb7y4Lun92CTiZKFiAjsV
         LeJg==
X-Gm-Message-State: AO0yUKV9byLu/dVRA+a2/uqNw6s5o1Z65FXg3bv1cg6veCqAg/Fts0Ij
        B7vPHmcwpbskp890s8A5ASHaZPWlfaE=
X-Google-Smtp-Source: AK7set+lGRVgqCvTAlOWkDWUXK2qRiOlAyqjXOmkeTiocYZ6VJUlOBKDGXKULYPkl+YRhFodxJoZ3Q==
X-Received: by 2002:a5e:c702:0:b0:74c:e43e:48f7 with SMTP id f2-20020a5ec702000000b0074ce43e48f7mr125807iop.13.1679344362633;
        Mon, 20 Mar 2023 13:32:42 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o15-20020a02a1cf000000b003b015157f47sm3502646jah.9.2023.03.20.13.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 13:32:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 20 Mar 2023 13:32:41 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Cc:     robh+dt@kernel.org, jdelvare@suse.com,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        eajames@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/5] docs: hwmon: Add documenttaion for acbel-crps PSU
Message-ID: <3298cf17-5160-4543-ae72-0daae8384d05@roeck-us.net>
References: <20230320154019.1943770-1-lakshmiy@us.ibm.com>
 <20230320154019.1943770-5-lakshmiy@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320154019.1943770-5-lakshmiy@us.ibm.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 10:40:18AM -0500, Lakshmi Yadlapati wrote:
> Add documentation changes for acbel-crps psu
> 
> Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
> ---
>  Documentation/hwmon/acbel-crps.rst | 81 ++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/hwmon/acbel-crps.rst
> 
> diff --git a/Documentation/hwmon/acbel-crps.rst b/Documentation/hwmon/acbel-crps.rst
> new file mode 100644
> index 000000000000..89a43fb88c8c
> --- /dev/null
> +++ b/Documentation/hwmon/acbel-crps.rst
> @@ -0,0 +1,81 @@
> +Kernel driver acbel-crps
> +=======================
> +
> +Supported chips:
> +
> +  * ACBEL Common Redundant Power Supply.
> +  Supported models: FSG032-00xG
> +
> +Author: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
> +
> +Description
> +-----------
> +
> +This driver supports ACBEL Common Redundant Power Supply. This driver
> +is a client to the core PMBus driver.

No, it supports the FSG032-00xG power supply. Neither the driver nor its
documentation should claim otherwise.

> +
> +Usage Notes
> +-----------
> +
> +This driver does not auto-detect devices. You will have to instantiate the
> +devices explicitly. Please see Documentation/i2c/instantiating-devices.rst for
> +details.
> +
> +Sysfs entries
> +-------------
> +
> +The following attributes are supported:
> +
> +======================= ======================================================
> +curr1_crit          Critical maximum current.
> +curr1_crit_alarm    Input current critical alarm.
> +curr1_input         Measured output current.
> +curr1_label         "iin"
> +curr1_max           Maximum input current.
> +curr1_max_alarm     Maximum input current high alarm.
> +curr1_rated_max     Maximum rated input current.
> +curr2_crit          Critical maximum current.
> +curr2_crit_alarm    Output current critical alarm.
> +curr2_input         Measured output current.
> +curr2_label         "iout1"
> +curr2_max           Maximum output current.
> +curr2_max_alarm     Output current high alarm.
> +curr2_rated_max     Maximum rated output current.
> +
> +
> +fan1_alarm          Fan 1 warning.
> +fan1_fault	    Fan 1 fault.
> +fan1_input	    Fan 1 speed in RPM.
> +fan1_target         Set fan speed reference.
> +
> +in1_alarm           Input voltage under-voltage alarm.
> +in1_input           Measured input voltage.
> +in1_label           "vin"
> +in1_rated_max       Maximum rated input voltage.
> +in1_rated_min       Minimum rated input voltage.
> +in2_crit            Critical maximum output voltage.
> +in2_crit_alarm      Output voltage critical high alarm.
> +in2_input           Measured output voltage.
> +in2_label           "vout1"
> +in2_lcrit           Critical minimum output voltage.
> +in2_lcrit_alarm     Output voltage critical low alarm.
> +in2_rated_max       Maximum rated output voltage.
> +in2_rated_min       Minimum rated output voltage.
> +
> +power1_alarm        Input fault or alarm.
> +power1_input        Measured input power.
> +power1_label        "pin"
> +power1_max          Input power limit.
> +power1_rated_max    Maximum rated input power.
> +power2_crit         Critical output power limit.
> +power2_crit_alarm   Output power crit alarm limit exceeded.
> +power2_input        Measured output power.
> +power2_label        "pout"
> +power2_max          Output power limit.
> +power2_max_alarm    Output power high alarm.
> +power2_rated_max    Maximum rated output power.
> +
> +temp[1-3]_input     Measured temperature.
> +temp[1-2]_max       Maximum temperature.
> +temp[1-3]_rated_max Temperature high alarm.
> +======================= ======================================================
> -- 
> 2.37.2
> 
