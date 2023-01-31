Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33666830F4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbjAaPLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbjAaPKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:10:38 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDCA53E77;
        Tue, 31 Jan 2023 07:08:43 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1631b928691so19648453fac.11;
        Tue, 31 Jan 2023 07:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tc5Kvp0umQS2+cFz/6CoiaZuikDRmqi00WdsNv9qzeM=;
        b=RFbALft+O8FOTZ6dBGJ+XXGD0PT4vCYMATFMiWsAfqgDWgSBMwQf//bFkGd4kwVRGp
         svXtnuKsZPUz6WYFo6DP7L3r8AC7Gd/6nHbt3+6hkxN65jozJa14KK4aPeGq9tb7WXSN
         lasKuvBYrrplr+nhJL42VS8X6hEzJLKnyJq7cfC/Gneam7+19vf+fGB7pWBtHWZ00AW0
         mcLIQAKJrnQpqWdkRQweEIURvLKutv/ZwsNGNtMIVaHgvvGiMpWz/5Pqcwu7xoblrUoo
         sgb2sm1XJSnPV9zaL12EhuqeNtQ0reXZ/Ek8l3+cmTFPcEuB97yc2VNwjBoI4mw5GTdt
         5UGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tc5Kvp0umQS2+cFz/6CoiaZuikDRmqi00WdsNv9qzeM=;
        b=ALyVQHnrcRdDUcty+IKZ9lJbueKyytNoaS09cM6jetfeXFPVfHB9QknJVdzUh/xTJZ
         F8DjJx12lTEy7GrONU4RAj5OU+a111u+OoHeUKgQ/q7Fl4T8LHHTs9nQgHTA+HVita4g
         CxbzfgnHew44jUFRb0Aixq+T2Ln49wep/bmfF4JZfa9T241qnrOV6s6BCVm15hnLyYrh
         Ns6K7qPHCIPnYyl0M8vHxaH+F9XOIJBKgntOQHTTWy6bcSSEN4FuYcZJrx12XPC2aN6H
         IBwMUJx0qahEJ3r2sk8AasKvlYhj45Tiu4X/5ADvz4tQKt9ilfaYyYzkWHlzQRfyAzsn
         rV0Q==
X-Gm-Message-State: AO0yUKWXqudFSVZdPiE8oFJ2MLNpIQDEd0LNfrAXBO1YMtMk2nRQTI2/
        9SS/XIk2PXTuJZz1JI/zMHW1FKTxrRE=
X-Google-Smtp-Source: AK7set9A/kk3t6DfM37h61mZmJqtmBN4LFXqhOlPw5VuWGO7oM4LE9C8DoZatsTrczMjFjzTHabLxg==
X-Received: by 2002:a05:6870:ea87:b0:163:b347:22f7 with SMTP id s7-20020a056870ea8700b00163b34722f7mr4414849oap.28.1675177664747;
        Tue, 31 Jan 2023 07:07:44 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c17-20020a056870479100b0014fd25bd3b5sm6697779oaq.0.2023.01.31.07.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 07:07:44 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 31 Jan 2023 07:07:43 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Aleksa Savic <savicaleksa83@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, Jack Doan <me@jackdoan.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (aquacomputer_d5next) Add support for
 Aquacomputer Poweradjust 3
Message-ID: <20230131150743.GA3592045@roeck-us.net>
References: <20230131101210.8095-1-savicaleksa83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131101210.8095-1-savicaleksa83@gmail.com>
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

On Tue, Jan 31, 2023 at 11:12:09AM +0100, Aleksa Savic wrote:
> Extend aquacomputer_d5next driver to expose the temp sensor of the
> Aquacomputer Poweradjust 3 fan controller, which communicates
> through a proprietary USB HID protocol.
> 
> The Poweradjust 3 is not currently known to expose firmware version
> and serial number, so don't create debugfs entries if their values
> can't be retrieved.
> 
> Tested by a user on Github [1].
> 
> [1] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/issues/57
> 
> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>

Applied to hwmon-next.

Thanks,
Guenter
