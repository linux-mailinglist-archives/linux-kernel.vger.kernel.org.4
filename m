Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCCF6DCA2C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 19:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjDJRr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 13:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjDJRrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 13:47:21 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9816A171D;
        Mon, 10 Apr 2023 10:47:20 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 90-20020a17090a0fe300b0023b4bcf0727so5176058pjz.0;
        Mon, 10 Apr 2023 10:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681148840; x=1683740840;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cr+P4eQTU9Vci95Nf3Bi2ST+2LVkNelGWi03CMRWAjM=;
        b=QSfGh50QyLv/eoZ2W7hOUWwqwgNI8eWcoyPHo2TKoQWDKd0elJLEG5skng9ooSBsiV
         3Rpd/397kqNfZMjo9RvLGGjS84VF/jGMe0fvj2zv8s8vQ4JW5zhfnyE1SV2qYzUiOa2w
         niCkhzbmYOtYbMhdERDOyaVCmWZBumcJg7REsxz/cMOx04eKgZycYVSK4gi5e4cEhICY
         FvkcHEbxubZLGPeTHIsYsWy2gcYggFZV85raWk4Jel9fOC0ZEjGCAmY8mCfN3JqL0El8
         86f76+Nw/47s4skObs5H97sy/UsuiNuYfHDtFVxb+yyJ4Y41pN8vJ46nNhSNEd7ElU+P
         usuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681148840; x=1683740840;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cr+P4eQTU9Vci95Nf3Bi2ST+2LVkNelGWi03CMRWAjM=;
        b=iyofRCfELkCLxXnR+CC96hx9FgaWgohb/BeEqM18CWPXBbZr8ogKvwI4pBqD/gVmjq
         ca7jsX5bV8s6Oc2UsbJe7e6F6Y5rJwOqtRMV7Yu5o0XK7R8+QMBenmGAJRwharZeNvYI
         RydQUZtG3tirqQDAcj8dj/e4xDoBSgq5Zql3Xc3OUeqo/o8uBotaPU2Ii93zqYdRcMJb
         9reZHTatnqENhvRXaO9v+jX1XE2iyJyLh165XmJ8C33uz6EvQbvVFqpUm5hKXp89OdY3
         87hpGqDG7LmXXMKDn4XjCFd9o9mSuN06JcDc/MBHCO0ugQD4eNYMHTyae8kzshlnaCoP
         sI1A==
X-Gm-Message-State: AAQBX9cJXpKGiNHjOYPs232Z5c5rryFgR9bTs8f0jILjOo6cDkRiPep2
        N8rGPD4ZkrwO6dLxXfMhC/E=
X-Google-Smtp-Source: AKy350btrLTNHJaCXCGldTWnBh5w0d4Y39rCJy6YYG3darKqRhkWRU/mzJhKbrnB2f9FxfpaYS4y8w==
X-Received: by 2002:a17:903:1c3:b0:1a5:167e:f482 with SMTP id e3-20020a17090301c300b001a5167ef482mr14015521plh.20.1681148840018;
        Mon, 10 Apr 2023 10:47:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 37-20020a630e65000000b00513ec871c01sm6952935pgo.16.2023.04.10.10.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 10:47:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 10 Apr 2023 10:47:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Naresh Solanki <naresh.solanki@9elements.com>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, Sascha Hauer <sha@pengutronix.de>,
        jerome Neanne <jneanne@baylibre.com>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>
Subject: Re: [PATCH v2 2/3] hwmon: (pmbus/core): Add regulator event support
Message-ID: <b49cc518-634e-4812-ae4a-ee6ec45b42f2@roeck-us.net>
References: <c88d3cdd-fb2f-c3ac-a9e8-e49f8e98b811@gmail.com>
 <17934bff-f728-d57a-c3c8-956634bd48c8@roeck-us.net>
 <3be67394-6082-1aeb-8a8d-90149217bdc7@gmail.com>
 <aea044ab-3a83-2369-aff7-5ef153618619@roeck-us.net>
 <0672fe4d-7293-4374-9186-29b008e5f8a2@sirena.org.uk>
 <CANhJrGO3X7pSsMBg6Gtf-q3=_JiCX4Qs=pGudL=etooM2F676g@mail.gmail.com>
 <d6a3ca82-7245-45e1-b8ff-a9970671b04f@sirena.org.uk>
 <CANhJrGMkwi1TVW_wGw=Boj1vRO_wGrd9=atOxKfbbdM4cwPGsw@mail.gmail.com>
 <7c71d182-2ac5-b01e-2875-5060fb509056@roeck-us.net>
 <65e06627-c368-d081-e18f-a45f245c37ab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65e06627-c368-d081-e18f-a45f245c37ab@gmail.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 07:53:46PM +0300, Matti Vaittinen wrote:
> On 4/10/23 17:40, Guenter Roeck wrote:
> > On 4/10/23 01:19, Matti Vaittinen wrote:
> > > to 6. huhtik. 2023 klo 16.43 Mark Brown (broonie@kernel.org) kirjoitti:
> > > > 
> > > > On Thu, Apr 06, 2023 at 11:00:02AM +0300, Matti Vaittinen wrote:
> > > > > ke 5. huhtik. 2023 klo 18.19 Mark Brown (broonie@kernel.org) kirjoitti:
> > > > > > On Wed, Apr 05, 2023 at 07:18:32AM -0700, Guenter Roeck wrote:
> > > 
> > > > > > It can also try to avoid
> > > > > > interacting with hardware if that might not work.
> > > > 
> > > > > It'd be great to have documentation / specification for sending and/or
> > > > > handling the regulator events. I don't think we currently have such.
> > > > > As far as I understand, the notifications can be picked up by all
> > > > > consumers of a regulator. I am a bit worried about:
> > > > > a) Situations where notification handlers 'collide' by doing 'actions'
> > > > > which are unexpected by other handlers
> > > > 
> > > > I'm not sure what you're expecting there?  A device working with itself
> > > > shouldn't disrupt any other users.
> > > 
> > > I have no concrete idea, just a vague uneasy feeling knowing that
> > > devices tend to interact with each other. I guess it is more about the
> > > amount of uncertainty caused by my lack of knowledge regarding what
> > > could be done by these handlers. So, as I already said - if no one
> > > else is bothered by this then I definitely don't want to block the
> > > series. Still, if the error handling should be kept internal to PMBus
> > > - then we should probably either say that consumer drivers must not
> > > (forcibly) turn off the supply when receiving these notifications - or
> > > not send these notifications from PMBus and allow PMBus to decide
> > > error handling internally. (Again, I don't know if any in-tree
> > > consumer drivers do turn off the supply regulator in error handlers -
> > > but I don't think it is actually forbidden). Or am I just making  a
> > > problem that does not exist?
> > > 
> > 
> > For my part I (still) don't understand why this is considered a problem
> > for this driver but not for all the other drivers reporting various
> > error conditions to the regulator subsystem. At least some of them
> > also have programmable reaction to such error conditions.
> 
> I may not know the drivers you're referring to. And, as I said, maybe there
> is no problem.
> 
> To explain why I asked this question for this driver:
> 
> What caught my attention was use of the REGULATOR_EVENT_*_WARN flags, which
> were originally added so regulators could be flagging 'not yet
> critical'-errors Vs. the other, older REGULATOR_EVENT_* flags. From the
> discussions I have understood the older flags were informing severe hardware
> failures where system is typically thought to be no longer usable. I have
> understood that the most likely handling for such notification is shutting
> off the regulator. I have further understood that there are not many
> consumers doing handling of these events. (This is all just my understanding
> based on discussions - take it with grain of salt).
> 
> I was the one who added these warning level notifications. Thus, I have been
> following (only) use of those warnings. I have no proper insight to existing
> drivers using all these flags.
> 
> When grepping for the WARNING level regulator events I can find following
> drivers:
> drivers/regulator/bd9576-regulator.c
> drivers/regulator/max597x-regulator.c
> drivers/regulator/tps65219-regulator.c
> 
> The difference (in my head) between these and PMBus-core is that these are
> very specific PMIC ICs. The board designer should have a good understanding
> which of the power-rails may have 'warning level' failures, and which errors
> are 'critical'. They should select and set the IRQ limits and error
> severities in the device-tree accordingly.
> 
> PMBus core (again, in my head) is more generic purpose system. This is why I
> originally asked if the 'error severity' in PMBus specifies also the error
> handling - and if these regulator notifications map to intended handling.
> Now, after this discussion I think that:
> 
> PMBus has it's own error-handling which is implemented independently from
> these notifications. This handling should not be messed-up by regulator
> consumers, for example by touching the regulator state.
> 
> This is what made me think sending regulator notifications might not be the
> best approach - (but as I said, I may be wrong. I am no longer sure what
> kind of handling there is expected for these events. Furthermore, as we see
> below, I did not find in-tree consumers taking "radical" actions when
> receiving the notifications).
> 
> Yep, I didn't find other in-tree consumers for these notifications except:
> drivers/usb/host/ohci-da8xx.c
> 
> (I was not thorough so may have missed some, but seems there is not many
> in-tree consumers.)
> 
> I did only a very very brief shallow peek but it seems to me that even there
> driver only sets a flag - which is used in debug message. (I may have missed
> something here as well).
> 
> Judging this it seems to me that, at the moment, these notifications are
> mostly ignored by consumers - and they are sent by only a handful of
> devices. There probably exist some downstream users for those, but I have
> not heard of them. Maybe they are only used on very specific systems. This
> could explain why there has been no problems.
> 
> I know, I know. Lot's of guessing, assuming and hand waving. Sorry :/
> 

Oh, now the problem (though I still don't understand what the problem
actually is) is extended to warnings. I thought you were concerned
about errors.

Personally I think you are concerned about a non-issue, but without
explicit guidance from regulator maintainers (and no clear definition if
and when regulator notifications should or may be sent) I won't be able
to apply this series.

Having said this, I find the whole discussion kind of surreal,
especially since the PMBus drivers already report error states to the
regulator subsystem using the get_error_flags callback, but it is what
it is. Also, no, I won't revert that code without a clear explanation
of the _actual_ (not perceived) problem that such a revert is supposed
to solve.

Guenter
