Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF2F62FFBC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 23:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiKRWHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 17:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiKRWHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 17:07:16 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202DE97374;
        Fri, 18 Nov 2022 14:07:15 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id b124so6820250oia.4;
        Fri, 18 Nov 2022 14:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pWzms7J2TkO+xgfCdVXkkK79XDRFqGG/fY/SIvweUvU=;
        b=Q5STfrN7UbzeP7hnyJVkGDosHblR7fc7cdNGGNHTi6EoYVZ0Y+rNBHbrJISmvV6dXX
         axtjSFA+6JKU0qs+uWJv99i0g6EzuWhVI0s1J8tYM+sp6kPFcmv6mY5+CYpgqA+rAWKI
         WF+5x9O8VOAq4qL3ZvlFfUPNrtgVH7zQ+nL/7KKEXtLwNr/aHGgdgJiSTusVtsOv3Ow2
         sU5KPpmVNC19c8yZywvv+QYwBS7zqWNWrBoTWrRaaSFlgT+0bUS74UxOMo5WdccCw53I
         ykvyrNNdtEpAh3uKI5uu9kRiF85llyeP6iIt7s+ubMhzNbZ7ZwzslpT7BUmYSN/5tPCo
         KVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pWzms7J2TkO+xgfCdVXkkK79XDRFqGG/fY/SIvweUvU=;
        b=qB5FslYaafvuhWI7PbXLE2A9ZTEkOKKFhxaFmMUWgNB2pwgHIe9VoO5jgTrqda4NGP
         GBsORQB8Hb1j+dNJYOTWeFS+17pmNxDKUeRKrOLoTW8T1/mUoJvMbcb/it+IAHAe30wR
         hxTcLP0lXYsTUDynJH2mjv0UF9hXkGO6YbqCiXP5kX+raXyUXMLfWcAX/6BBN4Ui/0Jb
         i8I0WdFbLw+mNs3mrXZgkrE8I6i1i7N8mbVIJ7m7WMEcVBi/BdMZjkxld22dXcHtH1Gg
         hkXS3QGUeYDGTlR+8EJx8UZfOsqqr53TrgLifN54t861sCFkG8bXcs0lpHbux1ZJVFkH
         /yTg==
X-Gm-Message-State: ANoB5pkn0Lb/Oj6tsdwtxduCJxJvKCqfmCiGK2QDrAqm3ech6GwsT8Q1
        Mk28HVRP0D94PpA5Po8LDXojf+14cp4=
X-Google-Smtp-Source: AA0mqf7eg4YvDdA3w0Uk83OQ4dTFdvr8pVQ++gjzTIBMZ8k1iwyUTyWGiwY4j+zjZ07gFZiH4r1jQg==
X-Received: by 2002:a05:6808:111:b0:35b:4375:e9b9 with SMTP id b17-20020a056808011100b0035b4375e9b9mr1510068oie.175.1668809234392;
        Fri, 18 Nov 2022 14:07:14 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 10-20020aca090a000000b003547a3401e6sm1838348oij.43.2022.11.18.14.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 14:07:13 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 18 Nov 2022 14:07:11 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: pm_bus: core: Implement regulator get_status
Message-ID: <20221118220711.GA685644@roeck-us.net>
References: <20221118084637.1973838-1-Naresh.Solanki@9elements.com>
 <20221118121049.GB3670981@roeck-us.net>
 <0fb5b5e4-ac23-01c9-a4c7-356db9ab0763@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fb5b5e4-ac23-01c9-a4c7-356db9ab0763@9elements.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 08:32:26PM +0530, Naresh Solanki wrote:
> > > +
> > > +	mutex_lock(&data->update_lock);
> > > +	status = pmbus_get_status(client, page, PMBUS_STATUS_WORD);
> > > +	mutex_unlock(&data->update_lock);
> > 
> > I do not see the point of this lock here and elsewhere in this function.
> > If you want to ensure that the status is consistent, you would need to
> > hold the lock over the entire function, not repeatedly acquire and release
> > it. Even then there would be no guarantee that the status is consistent
> > because it can change anytime on the chip side.
> Will hold the lock till end of function. Agree that chip side, status may
> change any moment.
> 
> With this I got a question i.e., what should regulator status be reported if
> regulator had previously encountered some fault but currently while reading
> the status found that pgood bit indicate output power is good.
> Should we continue to still report historical fault or instead report
> current regulator output status based on pgood ?
> 
> IMHO, it should report regulator status as ON if pgood bit is clear(i.e.,
> output is good) & leave previously encountered error reporting to
> get_error_flag function.
> 
> I need your Suggestion here.
> 
That is really a question for the regulator subsystem. Personally I think
the current status should be reported, but that is just me.

Guenter
